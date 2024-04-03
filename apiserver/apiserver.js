require('./authentication/apiKeys.js');
require('dotenv').config();
const express = require('express');
const app = express();
const crypto = require('crypto');
const bcrypt = require('bcrypt');
const database = require('./authentication/database.js');
const limitRequest = require('./middlewares/limit_request.js');
const limitResponse = require('./middlewares/limit_response.js');
const webAppRequest = require('./middlewares/web_app_request.js');
const hmacAuthentication = require('./middlewares/hmac_autentication.js');

app.use(express.urlencoded({ extended: true }));
app.use(express.json()); // parse incoming JSON requests.

app.post('/api/user/web_app/login', webAppRequest(true), (req, res) => {
    const { userEmail, userPassword } = req.body;
    const query = `SELECT *
                    FROM user
                    JOIN user_profile ON user.user_id = user_profile.user_id
                    LEFT JOIN image ON user_profile.image_id = image.image_id
                    WHERE user.user_email = ?;`;

    database.query(query, [userEmail], (err, [user]) => {        
        if (err) {
            return res.status(500).json({ error: err.message });
        } else if (!user) {
            return res.status(404).json({ message: 'User not found', code: 'USER_NOT_FOUND'});
        } else {
            bcrypt.compare(userPassword, user.user_password.toString('binary')).then(result => {
                if (result) {
                    return res.status(200).json({
                        message: 'Login successful',
                        user: {
                            id: user.user_id,
                            identifier: user.user_identifier,
                            name: user.user_profile_name,
                            imageId: user.image_id,
                            imageAlt: user.image_alt,
                            loginTime: new Date().getTime
                        }
                    });
                } else {
                    return res.status(401).json({ message: 'wrong login credentials', code: 'WRONG_CREDENTIALS' });
                }
            }).catch(err => {
                console.log(err);
                return res.status(500).json({ error: err.message });
            });
        }
    });
});

app.post('/api/user/web_app/register', webAppRequest(true), (req, res) => {
    const { userIdentifier, userEmail, userPassword } = req.body;
    const query = 'INSERT INTO user (user_identifier, user_email, user_password) VALUES (?, ?, ?)';

    bcrypt.hash(userPassword, 10, (err, saltedHash) => {
        if (err) {
            console.log(err);
            return res.status(500).json({ error: err.message });
        } else {
            database.query(query, [userIdentifier, userEmail, Buffer.from(saltedHash, 'binary')], (err, result) => {
                if (err) {
                    try {
                        if (err.sqlMessage.match(/for key '(.+?)'/)[1] === 'user_email') {
                            return res.status(409).json({ message: 'the email is already registered, please choose another', code: 'ER_DUP_ENTRY_EMAIL' });
                        } else if (err.sqlMessage.match(/for key '(.+?)'/)[1] === 'user_identifier') {
                            return res.status(409).json({ message: 'the identifier you have chosen is not available, please choose another', code: 'ER_DUP_ENTRY_IDENTIFIER' });
                        }
                    } catch {}

                    console.log(err);
                    return res.status(500).json({ error: err.message });
                } else {
                    return res.status(200).json({ message: 'User registered successfully' });
                }
            });
        }
    });
});

app.get('/api/tracks', limitRequest(1200), hmacAuthentication, limitResponse(500), (req, res) => {
    const { // set an empty string if undefined
        quantity,
        pages,
        trackName = '',
        genreSubgenreName = '',
        licensingName = '',
        recordCompanyName = '',
        artistName = '',
        albumName = '',
        playlistName = ''
    } = { ...req.query };

    const offset = (parseInt(pages) || 0) * parseInt(quantity)

    const query = `SELECT t.*, AVG(ra.rating_level) AS rating
                    FROM track t
                    LEFT JOIN track_genre_subgenre tgs ON t.track_id = tgs.track_id
                    LEFT JOIN genre_subgenre gs ON tgs.genre_subgenre_id = gs.genre_subgenre_id
                    LEFT JOIN track_licensing tl ON t.track_id = tl.track_id
                    LEFT JOIN licensing l ON tl.licensing_id = l.licensing_id
                    LEFT JOIN track_record_company trc ON t.track_id = trc.track_id
                    LEFT JOIN record_company rc ON trc.record_company_id = rc.record_company_id
                    LEFT JOIN track_artist ta ON t.track_id = ta.track_id
                    LEFT JOIN artist a ON ta.artist_id = a.artist_id
                    LEFT JOIN track_album tal ON t.track_id = tal.track_id
                    LEFT JOIN album al ON tal.album_id = al.album_id
                    LEFT JOIN tracklist tlst ON t.track_id = tlst.track_id
                    LEFT JOIN playlist pl ON tlst.playlist_id = pl.playlist_id
                    LEFT JOIN reaction r ON t.track_id = r.track_id
                    LEFT JOIN rating ra ON r.reaction_id = ra.reaction_id
                    WHERE (? = '' OR t.track_name LIKE ?)
                    AND (? = '' OR gs.genre_subgenre_name LIKE ?)
                    AND (? = '' OR l.licensing_name LIKE ?)
                    AND (? = '' OR rc.record_company_name LIKE ?)
                    AND (? = '' OR a.artist_name LIKE ?)
                    AND (? = '' OR al.album_name LIKE ?)
                    AND (? = '' OR pl.playlist_name LIKE ?)
                    GROUP BY t.track_id
                    ORDER BY t.track_id
                    LIMIT ? OFFSET ?;`;

    database.query(query, [
        trackName, `%${trackName}%`,
        genreSubgenreName, `%${genreSubgenreName}%`,
        licensingName, `%${licensingName}%`,
        recordCompanyName, `%${recordCompanyName}%`,
        artistName, `%${artistName}%`,
        albumName, `%${albumName}%`,
        playlistName, `%${playlistName}%`,
        quantity,
        offset
    ], (err, tracks) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        } else {
            return res.status(200).json({
                message: 'success',
                totalItems: tracks.length,
                items: tracks
            });
        }
    });
});

app.listen(process.env.PORT || 4000, () => {
    console.log("API listening on port :4000 at http://localhost:4000/ for requests");
});
require('dotenv').config();
const crypto = require('crypto');
const sessionSecret = crypto.randomBytes(32).toString('hex');
const express = require('express');
const axios = require('axios');
const path = require('path');
const cookieParser = require('cookie-parser');
const sessions = require('express-session');
let app = express();
const encryptCredentials = require('./middlewares/encrypt_credentials.js');
const checkCredentials = require('./middlewares/check_credentials.js');
const hmacSignature = require('./middlewares/hmac_signature')

app.set('view engine', 'ejs');

app.use(cookieParser());
app.use(express.static(path.join(__dirname, './public')));
app.use(express.static(path.join(__dirname, '../database'))); // allow express to access images and tracks in the server
app.use(express.urlencoded({ extended: true }));
app.use(sessions({
        secret: sessionSecret,
        saveUninitialized: false, // determines whether a session should be created automatically for a user who hasn't logged in or visited the site before.
        cookie: { maxAge: 60 * 60 * 1000 },
        resave: false // determines whether the session should be saved even if it hasn't been modified during the request.
    })
);

app.get('/login', (req, res) => {
    return res.render('login');
});

app.post('/login', checkCredentials, encryptCredentials, (req, res) => {
    const { encrypted, iv } = req.body;
    let errors = []; // initialize the error variable

    axios.post('http://localhost:4000/api/user/web_app/login', { encrypted }, {
        headers: {
            'x-api-key': process.env.API_KEY,
            'x-iv': iv // include the IV in the headers as a hexadecimal string
        } // we use the name convention with X- for non-standard headers
    }).then(response => {
        console.log(response.data.message);
        req.session.user = response.data.user; // set the userId property on the session object
        return res.redirect('/dashboard');
    }).catch(err => {
        if (err.response?.data.code === 'WRONG_CREDENTIALS') {
            errors = [err.response.data.message];
            return res.render('login', { errors });
        } else if (err.response?.data.code === 'USER_NOT_FOUND') {
            errors = [err.response.data.message];
            return res.render('login', { errors });
        } else {
            console.log(err.response?.data);
            console.error('Error request to API:', err.message);
            return res.status(500).send('Internal Server Error');
        }
    });
});

app.get('/logout', (req, res) => {
    req.session.destroy(); // destroy the session
    return res.render('logout');
});

app.get('/register', (req, res) => {
    return res.render('register');
});

app.post('/register', checkCredentials, encryptCredentials, (req, res) => {
    const { encrypted, iv, userIdentifier } = req.body;
    let errors = [];

    axios.post('http://localhost:4000/api/user/web_app/register', { encrypted, userIdentifier }, {
        headers: {
            'x-api-key': process.env.API_KEY,
            'x-iv': iv
        }
    }).then(response => {
        console.log(response.data.message);
        return res.render('registration_success');
    }).catch(err => {
        if (err.response?.data.code === 'ER_DUP_ENTRY_EMAIL') {
            errors = [err.response.data.message];
            return res.render('register', { errors });
        } else if (err.response?.data.code === 'ER_DUP_ENTRY_IDENTIFIER') {
            errors = [err.response.data.message];
            return res.render('register', { errors });
        } else {
            console.log(err.response?.data);
            console.error('Error request to API:', err.message);
            return res.status(500).send('Internal Server Error');
        }
    });
});

app.get('/dashboard', (req, res) => {
    const user = req.session.user;
    let errors = [];
    
    if (!user) {
        errors = ['Access denied. Please log in first'];
        res.render('login', { errors });
    } else {
        let image;
        if (!user.imageId) { // use a random generated image if there's no image path in the database
            // Generate the MD5 hash of the user identifier
            const hash = crypto.createHash('md5').update(user.identifier).digest('hex');
            // Generate the Gravatar URL using the hash
            image = `https://www.gravatar.com/avatar/${hash}?d=identicon`;
        } else {
            image = `/image/${user.imageId}.jpg`;
        }

        return res.render('dashboard', { user, image });
    }
});

app.get('/tracks', (req, res) => {
    // use HMAC signature to validate the request. The web server needs to prove its identity
    const object = hmacSignature(req.query);

    axios.get('http://localhost:4000/api/tracks', object).then(response => {
        console.log(response.data);
        const tracks = response.data.items;

        tracks.forEach(track => {
            if (!track.image_id) {
                const hash = crypto.createHash('md5').update(track.track_name).digest('hex');
                track.image_id = `https://www.gravatar.com/avatar/${hash}?d=identicon`;
            } else {
                track.image_id = `/image/${track.image_id}.jpg`;
            }
        });

        return res.render('tracks', { tracks });
    }).catch(err => {
        console.log(err.response?.data);
        console.error('Error request to API:', err.message);
        return res.status(500).send('Internal Server Error');
    });
});

app.listen(process.env.PORT || 3000, () => {
    console.log("Web server listening on port :3000 at http://localhost:3000/ for requests");
});
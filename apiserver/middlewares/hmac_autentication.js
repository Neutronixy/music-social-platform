const crypto = require('crypto');
const database = require('../authentication/database.js');

const maxSkew = 5 * 1000; // Allow a maximum skew

// autenticate the request for general endpoints with hmac by using api key and secret key.
// if the request comes from the developer or the web server app or the admin, the request will be allowed.
const hmacAuthentication = (req, res, next) => {
    const apiKey = req.headers['x-api-key'];
    const { signature, ...message } = req.query; //  the rest of the properties are stored in a new object called message
    const timestamp = req.query.timestamp;
    delete req.query.signature;
    delete req.query.timestamp;
    let apiSecret;

    // check if the request is valid
    if (!apiKey) {
        return res.status(400).json({ message: 'Bad Request: api key is missing' });
    } else if (!timestamp) {
        return res.status(400).json({ message: 'Bad Request: timestamp is missing' });
    } else if (!signature) {
        return res.status(400).json({ message: 'Bad Request: signature is missing' });
    } else if ((Date.now() - timestamp) > maxSkew) { // check if the timestamp from the message is valid to guarantee protection against reply attacks
        return res.status(400).json({ message: 'Timestamp out of range. check your server time' });
    }    

    if (req.headers['x-api-key'] === process.env.API_KEY ) {
        req.query.admin = true; // the request comes from an admin or the web server app
        apiSecret = process.env.API_SECRET;
    } else {
        // Look up the user by the apiKey
        const query = 'SELECT user_id, user_secret_key FROM user WHERE user_api_key = ?';
        
        database.query(query, [apiKey], (err, [user]) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            } else if (!user) {
                return res.status(403).send('Invalid API key');
            } else { 
                apiSecret = user.user_secret_key;
                req.query.userId = user.user_id;
            }
        });

        req.query.admin = false; // the request comes from an user. An user id is included too
    }

    const computedSignature = crypto
        .createHmac('sha256', apiSecret)
        .update(JSON.stringify(message))
        .digest('hex');

    if (signature !== computedSignature) {
        return res.status(401).send('Invalid signature');
    }

    next(); // If everything checks out, allow the request to proceed
};

module.exports = hmacAuthentication;
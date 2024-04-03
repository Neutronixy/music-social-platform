const crypto = require('crypto');

const maxSkew = 5 * 1000; // Allow a maximum skew

const decryptCredentials = (req, res) => {
    const encrypted = req.body.encrypted;
    delete req.body.encrypted;
    const iv = Buffer.from(req.headers['x-iv'], 'hex');
    const decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(process.env.API_SECRET, 'hex'), iv);
    let decrypted = decipher.update(encrypted, 'hex', 'utf8');
    decrypted += decipher.final('utf8'); // the output will be a string of characters in the UTF-8 character set.
    const { email, password, timestamp } = JSON.parse(decrypted);

    // check if the timestamp from the message is valid to guarantee protection against message repetition
    if ((Date.now() - timestamp) > maxSkew) {
        return res.status(400).json({ message: 'Timestamp out of range. check your server time' });
    }
    
    req.body.userEmail = email;
    req.body.userPassword = password;
};

// this function will check if the request comes from the webserver app. If yes it checks if some credential needs to be decrypted
const webAppRequest = (credentials) => {
    return (req, res, next) => {
        if (req.headers['x-api-key'] !== process.env.API_KEY) {
            return res.status(403).json({ message: 'Invalid API key' });
        }
        
        // decrypt the credentials
        if (credentials) {
            try {
                decryptCredentials(req, res);
            } catch (err) {
                console.error(err.message);
                return res.status(401).json({ message: 'decryption failed' });
            }
        }
        next();
    }
};

module.exports = webAppRequest;
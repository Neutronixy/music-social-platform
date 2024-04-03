const crypto = require('crypto');

// encrypt credentials and return the data secured
const encryptCredentials = (req, res, next) => {
    const { email, password } = req.body;
    delete req.body.email;
    delete req.body.password;
    const iv = crypto.randomBytes(16); // typically generated randomly and is included in the encrypted message to the server so that the server can use it to decrypt the message.
    const cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(process.env.API_SECRET, 'hex'), iv); // returns a cipher object that can be used to encrypt data
    let encrypted = cipher.update(JSON.stringify({ email, password, timestamp: Date.now() }), 'utf8', 'hex'); // encrypt the data as a JSON object
    encrypted += cipher.final('hex'); // call returns the remaining encrypted data, which is then appended to the output encrypted variable
    req.body.encrypted = encrypted;
    req.body.iv = iv.toString('hex');
    next();
};

module.exports = encryptCredentials;
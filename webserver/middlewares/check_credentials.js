const validator = require('validator');

// check if credentials are in a valid format
const checkCredentials = (req, res, next) => {
    const { email, password, userIdentifier } = req.body;
    const errors = [];

    // check email
    if (!email) {
        errors.push('email is a mandatory field');
    } else if (!validator.isEmail(email)) {
        errors.push('Invalid email');
    }

    // check password
    if (!password) {
        errors.push('password is a mandatory field');
    } else if (!validator.isStrongPassword(password, {
        minLength: 8,
        maxLength: 20,
        minLowercase: 1,
        minUppercase: 1,
        minNumbers: 1,
        minSymbols: 1
    })) {
        errors.push('Password must be between 8 and 20 characters long and contain at least 1 lowercase letter, 1 uppercase letter, 1 special symbol, and 1 number');
    }

    // check user identifier if exists
    if (typeof userIdentifier !== 'undefined') {
        if (!userIdentifier) {
            errors.push('identifier is a mandatory field');
        } else if (userIdentifier.length > 50) {
            errors.push('identifier cannot be longer than 50 characters');
        } else if (!validator.matches(userIdentifier, /^[a-zA-Z0-9@]+$/)) {
            errors.push('identifier should contain only letters and numbers after the @ symbol');
        } else if (userIdentifier[0] !== '@') {
            errors.push('identifier should start with a @ character');
        }
    }

    // send errors if there are some
    if (errors.length > 0) {
        const page = req.originalUrl.split('/').pop();
        return res.render(page, { errors });
    }

    next();
};

module.exports = checkCredentials;
const fs = require('fs');
const crypto = require('crypto');
const length = 32;

// Generate random API key and secret key for the web server application
const webServerApiKey = crypto.randomBytes(length).toString('hex');
const webServerApiSecret = crypto.randomBytes(length).toString('hex');

// Store the API key and secret key in environment variables
process.env.API_KEY = webServerApiKey;
process.env.API_SECRET = webServerApiSecret;
fs.writeFileSync('../webserver/.env', `API_KEY = ${webServerApiKey}\nAPI_SECRET = ${webServerApiSecret}`);

console.log(`Web server's API key and API secret created and added to the enviroment variables and changed in the webserver .env file. Length = ${length}, name: API_KEY, API_SECRET`);
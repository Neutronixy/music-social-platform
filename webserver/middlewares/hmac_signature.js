const crypto = require('crypto');

// create a signature of the body and add it in the request brefore sending it to the api
const hmacSignature = (query) => {
    let object = {params: {}, headers: {}};
    object.params = query;
    object.params.timestamp = Date.now().toString(); // add the timestamp. MUST BE A STRING!
    
    // create signature
    const signature = crypto
        .createHmac('sha256', process.env.API_SECRET)
        .update(JSON.stringify(object.params))
        .digest('hex');

    object.params.signature = signature; // add the signature
    object.headers['x-api-key'] = process.env.API_KEY; // add the api key
    return object;
}

module.exports = hmacSignature;
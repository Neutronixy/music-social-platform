// define the maximum total weight allowed for an IP address
const maxWeight = 10000;

// define the maximum total weight allowed for an IP address before the ban
const maxWeightBan = 20000;

// reset the total weight every x time
const interval = 60 * 1000;

// reset the ban status after x time
const intervalBan = 120 * 1000;

let totalWeights = {};
let bannedUsers = {};
let timeBefore = Date.now();

// middleware function to enforce the weight limit. It will be applyed to the IP and will not limit requests from the webserver app
const limitRequests = (endpointWeight) => {
    return (req, res, next) => {
        if (req.headers['x-api-key'] !== process.env.API_KEY) {
            // reset the weight
            const resetWeight = timeBefore + interval
            if (Date.now() > resetWeight) {
                totalWeights = {};
                timeBefore = Date.now();
            };

            // check if the ip is banned
            const ip = req.ip;
            if (ip in bannedUsers) {
                if (Date.now() < bannedUsers[ip]) {
                    return res.status(403).json({ message: `You are banned for a while`});
                } else {
                    delete bannedUsers[ip];
                }
            }

            // increase the total weight and check if the user is banned or blocked
            // and set important headers for handle limits easier for developers like Retry-After
            totalWeights[ip] = (totalWeights[ip] || 0) + endpointWeight;
            if (totalWeights[ip] > maxWeightBan) {
                bannedUsers[ip] = Date.now() + intervalBan;
                return res.status(403).json({ message: `Stop spamming, you are banned until ${new Date(bannedUsers[ip])}`, banTimestamp: bannedUsers[ip] });
            } else if (totalWeights[ip] > maxWeight) {
                res.setHeader('Retry-After', resetWeight - Date.now());
                return res.status(429).json({ message: "Too many requests" });
            } else {
                res.setHeader('X-Remaining-Weight', maxWeight - endpointWeight);
                res.setHeader('X-Endpoint-Weight', endpointWeight);
            };
        }
        
        next();
    }
};

module.exports = limitRequests;
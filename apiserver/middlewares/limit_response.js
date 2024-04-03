// get the maximum allowed quantity for the endpoint and set a default one if not given
// check if the quantity is bigger than the limit and block the request
const limitResponse = (limit) => {
    return (req, res, next) => {
        const quantity = parseInt(req.query.quantity) || limit;
        if (isNaN(quantity) || quantity < 0) {
            return res.status(400).json({ message: 'Invalid quantity parameter' });
        } else if (quantity > limit) {
            return res.status(400).json({ message: `Maximum ${limit} items allowed` });
        }
        req.query.quantity = quantity; // set the validated quantity in case a quantity was not given
        next();
    }
};

module.exports = limitResponse;
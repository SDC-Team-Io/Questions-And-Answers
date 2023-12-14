const cache = require('memory-cache');
//need to add an item to the cache if not there(after sending req to the database), send cached data back if request key exists in the cache, and
const cacheMiddleware = (cacheSeconds) => {
  return (req, res, next) => {
    if (req.method === 'GET') {
      //set the key to be used by the cache
      const key = req.originalUrl;
      //get the cached data (will be undefined if its not there)
      const cachedData = cache.get(key);
      if (cachedData !== null) {
        //send back the cached data if it was there
        //was considering refreshing the cache time but popular requests getting refreshed once every 10-15 seconds is negligible... and without an absolute cache clear could lead to too much memory usage for the cache...
        res.setHeader('Content-Type', 'application/json');
        res.send(cachedData);
      } else {
        //save the original res.send and then override the function to add the uncached res to the cache for cacheSeconds.
        const oldSend = res.send.bind(res);
        res.send = (body) => {
          //put the res from the database into the cache with the key and the duration converted to seconds!
          cache.put(key, body, cacheSeconds * 1000);
          //send the data back using the original send method
          oldSend(body);
        }
        next();
      }
    } else {
      next();
    }
  }

}
module.exports = cacheMiddleware;
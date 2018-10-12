module.exports = function(app) {
    const types = require('../controller/type.controller.js');
    
    // Init data: Types 
    app.get('/api/types/init', types.init);

    // Retrieve all types
    app.get('/api/types', types.findAll);
}

// Generated by CoffeeScript 1.10.0
(function() {
  var PORT, app, express;

  PORT = 8090;

  express = require('express');

  app = express();

  app.use('/', express["static"]('public'));

  app.listen(PORT);

}).call(this);

//# sourceMappingURL=server.js.map

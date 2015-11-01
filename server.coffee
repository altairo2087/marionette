PORT = 8090

express = require 'express'

app = express()
app.use('/', express.static('public'));

app.listen PORT
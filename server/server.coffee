express = require 'express'
mongoose = require 'mongoose'

# var datasetController = require ('./controllers/dataset_controller');
indexController = require './controllers/index_controller'

app = express()

mongodbURL = process.env.MONGO_URI || 'mongodb://localhost/mommyHelp'

mongoose.connect mongodbURL

# app.configure ->
# app.use express.compress()
app.set 'views', "#{__dirname}/views"
app.set 'view engine', 'jade'
# app.use express.cookieParser()
# app.use express.session({secret: '1234567890QWERTY'})
# app.use express.bodyParser()
app.use express.static("#{__dirname}/../public/")

app.use '/', indexController

  # app.get ('/getDatasets', datasetController.getDatasets);

  # app.put ('/update', datasetController.updateDataset);

module.exports = app

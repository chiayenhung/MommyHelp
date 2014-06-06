express = require 'express'
mongoose = require 'mongoose'

# var datasetController = require ('./controllers/dataset_controller');

app = express()

mongodbURL = process.env.MONGO_URI || 'mongodb://localhost/mommyHelp'

mongoose.connect mongodbURL

app.configure ->
  app.use express.compress()
  app.set 'title', "NYU Message"
  app.set 'views', "#{__dirname}/pages"
  app.set 'view engine', 'html'
  app.use express.cookieParser()
  app.use express.session({secret: '1234567890QWERTY'})
  app.use express.bodyParser()
  app.use express.static("#{__dirname}/../public/")

  # app.get '/fillData', datasetController.fillData

  # app.get ('/getDatasets', datasetController.getDatasets);

  # app.put ('/update', datasetController.updateDataset);

module.exports = app

express = require 'express'
router = express.Router()

router.get '/', (req, res) ->
  res.render 'index/index'

router.get '/login', (req, res) ->
  res.render 'index/login'

router.get '/signup', (req, res) ->
  res.render 'index/signup'

module.exports = router

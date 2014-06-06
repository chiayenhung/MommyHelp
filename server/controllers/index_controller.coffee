express = require 'express'
router = express.Router()

User = require '../models/users'

router.get '/', (req, res) ->
  res.render 'index/index'

router.get '/login', (req, res) ->
  res.render 'index/login'

router.get '/signup', (req, res) ->
  res.render 'index/signup'

router.post '/submit', (req, res) ->
  data = req.body
  user = new User
    username: data.username
    password: data.password
    email: data.email
    createTime: new Date()
    lastLogin: new Date()
  user.save (err, user) ->
    if err
      res.send err, 500
    else
      res.render 'index/index'

module.exports = router

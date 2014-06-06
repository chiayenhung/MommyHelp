mongoose = require ('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

User = new Schema
  username: String
  password: String
  email: String
  createTime: Date
  lastLogin: Date

module.exports = mongoose.model 'User', User

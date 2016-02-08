mongoose = require 'mongoose'

module.exports = mongoose.model 'log', mongoose.Schema
    
    time:       
        type: Date
        default : Date
    
    type: 
        type: String
    
    content:    
        type: String
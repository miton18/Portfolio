mongoose = require 'mongoose'

module.exports = mongoose.model 'message', mongoose.Schema
    
    email: 
        type: String
        match: /^[0-9a-z._-]+@{1}[0-9a-z.-]{2,}[.]{1}[a-z]{2,5}$/
        
    content:    
        type: String
        
    time:       
        type: Date
        default : Date
        
    ip:         
        type: String
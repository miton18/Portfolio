var express     = require('express');
var app         = express();
var bodyParser  = require("body-parser");

var exec        = require('child_process').exec;



app.use(bodyParser.urlencoded({ extended: false }));

app.use( '/', express.static(__dirname + '/build'));

app.post('/update', function(req, res) {

    rep = req.body;

    exec( 'git pull origin V3' , function (error, stdout, stderr) {
        if (error) {
            rep += error;
        }
        if (stdout) {
            rep += stdout;
        }
        if (stderr) {
            rep += stderr;
        }
    });
    res.send( rep );
});

app.listen( 80 );

console.log('starting');

const dbConnect = require('./mongodb')
var log = console.log;

dbConnect().then((resp)=>{
    resp.find({}).toArray().then((data)=>{
        log(data);
    })
})



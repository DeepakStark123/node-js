const http = require('node:http');
const color = require('colors');
const dataobj = require("./data")
const log = console.log;

// Create an HTTP tunneling proxy
// log('Hello'.red + ' World'.green);

///---method-1---
// http.createServer((req, res) => {
//     res.write("<h1>hello Deepak</h1>");
//     res.end();
//   }).listen(4500)

///---method-2---
http.createServer(respfun).listen(4500)

function respfun(req, res){
    log("Api Called".yellow)
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.write(JSON.stringify(dataobj.data));
    res.end();
}



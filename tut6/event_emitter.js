/*
Node.js uses events module to create and handle custom events. 
The EventEmitter class can be used to create and handle custom 
events module.
*/

const express = require('express');
const app = express();
const EventEmitter = require('node:events');
const eventEmitter = new EventEmitter();
app.listen(5500);
let count = 0;

eventEmitter.on('countAPI', () => {
  count++;
  console.log("Event Calling Count = ",count);
});

//--api--
app.get('/',(req,resp)=>{
  resp.send("get api called");
  eventEmitter.emit('countAPI');
});

//--search--
app.get('/search',(req,resp)=>{
  resp.send("search api called");
});

//--update--
app.get('/update',(req,resp)=>{
  resp.send("update api called");
});

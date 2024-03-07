const express = require('express');
const { createServer } = require('node:http');
const path = require('path');
const PORT = process.env.PORT || 4500;
const publicDir = path.join(__dirname, 'public');
const app = express();
const server = createServer(app);
app.use(express.static(publicDir));

//-----Socket-Connection----
const { Server } = require('socket.io');
const io = new Server(server);

let socketsConnected = new Set();

io.on('connection', (socket) => {
  //---connected---
  console.log('A user connected with id =>', socket.id);
  socketsConnected.add(socket.id);
  io.emit('clients-total', socketsConnected.size);
  console.log('Total connected users =>', socketsConnected.size);

  //---dis-connect---
  socket.on('disconnect', () => {
    console.log('A user disconnected with id =>', socket.id);
    socketsConnected.delete(socket.id);
    io.emit('clients-total', socketsConnected.size);
    console.log('Now Total Connected Users =>', socketsConnected.size);
  });

  //---Send-message---
  socket.on("send_message", (data) => {
    console.log(data);
    socket.broadcast.emit("receive_message", data)
  })

  // socket.on('message', (data) => {
  //   // console.log(data)
  //   socket.broadcast.emit('receive_message', data)
  // })
});

//----listen-Port-4500-----
server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

///---init-page---
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html')); 
});


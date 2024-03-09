const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const mongoose = require('mongoose');
const UserRouter = require('./routes/user_route');
const socketHandler = require('./socketHandler');

//---Database-Connection---
const dbName = "whatsapp_clone";
const PORT = process.env.PORT || 5500;
const MONGODB_URI = `mongodb://localhost:27017/${dbName}`;

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

// Connect to MongoDB
mongoose.connect(MONGODB_URI);
const dbConnect = mongoose.connection;
dbConnect.on('error', console.error.bind(console, 'connection error:'));
dbConnect.once('open', () => {
    console.log('Connected to MongoDB');
});

// Middleware
app.use(express.json());
app.use('/', UserRouter);

// Socket.IO integration
socketHandler(io);

// Start server
server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});

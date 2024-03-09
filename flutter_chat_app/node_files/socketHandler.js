const socketIo = require('socket.io');
const UserModel = require('./models/user_model');
const MessageModel = require('./models/message_model');

module.exports = function(io) {
  io.on('connection', (socket) => {
    console.log('A user connected with id =>', socket.id);
  
    socket.on('disconnect', () => {
      console.log('A user disconnected with id =>', socket.id);
    });

    // Handle incoming messages
    socket.on('send_message', async (data) => {
      try {
        // Save message to database
        const message = new Message({
          sender: data.senderId,
          recipient: data.recipientId,
          text: data.text,
        });
        await message.save();

        // Broadcast message to recipients
        socket.to(data.recipientId).emit('receive_message', data);
      } catch (error) {
        console.error('Error sending message:', error);
      }
    });
  });
};

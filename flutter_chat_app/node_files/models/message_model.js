const mongoose = require('mongoose');
const { Schema } = mongoose;

// Message schema
const messageSchema = new Schema({
  sender: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  recipient: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  timestamp: { type: Date, default: Date.now },
  text: String,
});

// Define Message Models
const MessageModel = mongoose.model("messages", messageSchema);
module.exports = MessageModel;

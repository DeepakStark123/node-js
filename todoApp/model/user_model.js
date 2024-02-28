const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  email: { type: String, lowercase: true, required: true, unique: true },
  password: { type: String, required: true },
});

const userModel = mongoose.model("users", userSchema);

//---exporting variables--
module.exports = userModel;

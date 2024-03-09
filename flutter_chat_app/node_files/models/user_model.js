const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const { Schema } = mongoose;

const userSchema = new Schema(
  {
    userName: {
      type: String,
      required: [true, "User name is required"],
    },
    email: {
      type: String,
      lowercase: true,
      required: [true, "User email can't be empty"],
      match: [
        /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
        "Email format is not correct",
      ],
      unique: true,
    },
    password: {
      type: String,
      required: [true, "Password is required"],
    },
    profilePhoto: {
      type: String,
    },
  },
  { timestamps: true }
);

const UserModel = mongoose.model("users", userSchema);
module.exports = UserModel;

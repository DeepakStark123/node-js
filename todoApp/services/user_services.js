const UserModel = require("../models/user_model");
const jwt = require("jsonwebtoken");

class UserService {

  //----Register-User--
  static async registerUser(email, password) {
    try {
      const createUser = new UserModel({ email, password });
      return await createUser.save();
    } catch (error) {
      throw error;
    }
  }
  //----Check-User-Exist-Or-Not----
  static async checkUserExistence(email) {
    try {
      return await UserModel.findOne({ email });
    } catch (error) {
      console.log(err);
      throw error;
    }
  }

  //----Generate-Access-Token---
  static async generateAccessToken(tokenData, JWTSecret_Key, JWT_EXPIRE) {
    return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
  }
}

module.exports = UserService;

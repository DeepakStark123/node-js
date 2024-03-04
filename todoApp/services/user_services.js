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

  //----Check-User-Exist-Or-Not--ById--
  static async checkUserById(userId)  {
    try {
      const user = await UserModel.findById(userId);
      // const user = await User.findOne({ _id: userId });
      if (user) {
        console.log('User exists:', user);
        return true;
      } else {
        console.log('User does not exist');
        return false;
      }
    } catch (error) {
      console.error('Error checking user ID:', error);
      return false;
    }
  };

  //----Generate-Access-Token---
  static async generateAccessToken(tokenData, JWTSecret_Key, JWT_EXPIRE) {
    return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
  }
}

module.exports = UserService;

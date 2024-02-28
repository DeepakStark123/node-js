const UserModel = require('../model/user_model');

class UserService {
    static async registerUser(email,password) {
        try {
            const newUser = new UserModel(email,password);
            return await newUser.save();
        } catch (error) {
            throw error;
        }
    }
}

module.exports = UserService;

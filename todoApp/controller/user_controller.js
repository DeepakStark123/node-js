const UserService = require('../services/user_services');

//---User-registration----
exports.register = async (req, res, next)=> {
    try {
        console.log("ReqBody==>", req.body);
        const { email, password } = req.body;
        const duplicate = await UserService.checkUserExistence(email);
        if (duplicate) {
            throw new Error(`UserEmail ${email}, Already Registered`);
        }
        const response = await UserService.registerUser(email, password);
        res.json({ status: true, success: 'User registered successfully' });
        // res.status(200).json({ status: true, success: "User registered successfully"});
    } catch (error) {
        console.log('Registration Error---->',error);
        res.status(500).json({ error: error.message });
    }
};

//---User-Login--
exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            throw new Error('Parameter are not correct');
        }
        let user = await UserService.checkUserExistence(email);
        if (!user) {
            throw new Error('User does not exist');
        }
        const isPasswordCorrect = await user.comparePassword(password);
        if (isPasswordCorrect === false) {
            throw new Error(`Username or Password does not match`);
        }
        // Creating Token
        let tokenData = { _id: user._id, email: user.email };
        const token = await UserService.generateAccessToken(tokenData,"secret","1h")
        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log('Login Error---->',error);
        next(error);
    }
}

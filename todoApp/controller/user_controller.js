const UserService = require('../services/user_services');


//---exporting variables--
exports.register = async (req, res, next)=> {
    try {
        const {email,password} = req.body;
        const successResp = await UserService.registerUser(email,password);
        res.json({status:200,success:"User Register Successfully"})
    } catch (error) {
        res.status(500).json({ error: error.message });
        console.log(error);
    }
};


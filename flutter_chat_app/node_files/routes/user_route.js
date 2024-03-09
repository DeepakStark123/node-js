const router = require("express").Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const UserModel = require("../models/user_model");
const JWTSecret_Key = "deepak_secret_key";
const JWT_EXPIRE_Time = "24h";

// Route handler for user registration
router.post("/register", async (req, res) => {
  try {
    // Email and password can't be empty
    if (!req.body.email || !req.body.password) {
      return res
        .status(200)
        .json({ status: false, message: "Email and password are required" });
    }
    if(!req.body.userName){
      return res
      .status(200)
      .json({ status: false, message: "User name is required" });
    }

    // Check if the email is already registered
    const existingUser = await UserModel.findOne({ email: req.body.email });
    if (existingUser) {
      return res
        .status(200)
        .json({
          status: false,
          message: `User with email ${eq.body.email} already exists`,
        });
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(req.body.password, 10);

    // Create a new user object
    const newUser = new UserModel({
      userName: req.body.userName,
      email: req.body.email,
      password: hashedPassword,
      profilePhoto: req.body.profilePhoto,
    });

    // Save the user to the database
    await newUser.save();
    res
      .status(200)
      .json({ status: true, message: "User registered successfully" });
    console.log("Registration Successfully");
  } catch (error) {
    if (
      error.errors &&
      error.errors.email &&
      error.errors.email.kind === "regexp"
    ) {
      return res
        .status(200)
        .json({ status: false, message: "Invalid email format" });
    }
    console.log("Registration Exceptions---->", error);
    return res
      .status(500)
      .json({ status: false, message: "Internal Server Error" });

  }
});

/// Route handler for user login
router.post("/login", async (req, res) => {
  try {
    // Email and password can't be empty
    if (!req.body.email || !req.body.password) {
      return res
        .status(200)
        .json({ status: false, message: "Email and password are required" });
    }

    // Find the user by email
    const existingUser = await UserModel.findOne({ email: req.body.email });
    if (!existingUser) {
      return res.status(200).json({ status: false, message: `User not found` });
    }

    // Compare the password
    const isMatch = await bcrypt.compare(req.body.password, existingUser.password);
    if (!isMatch) {
      return res
        .status(200)
        .json({ status: false, message: "Invalid password"});
    }

    // Generate JWT token
    const token = jwt.sign({ userId: existingUser._id }, JWTSecret_Key, {
      expiresIn: JWT_EXPIRE_Time,
    });

    res
      .status(200)
      .json({ status: true, message: "Login successful", token: token });
    console.log("Login Successfully");
  } catch (error) {
    console.log("Login Exceptions---->", error);
    return res
      .status(500)
      .json({ status: false, message: "Internal Server Error" });
  }
});


// Route handler to get all users
router.get("/users", async (req, res) => {
  try {
    // // Fetch all users from the database
    // const users = await UserModel.find();

    // Fetch all users from the database, excluding createdAt and updatedAt, and __v fields
     const users = await UserModel.find().select("-createdAt  -updatedAt  -__v");

    // Return the list of users
    res.status(200).json({ status: true, users: users });
  } catch (error) {
    console.log("Error fetching users:", error);
    res.status(500).json({ status: false, message: "Internal Server Error" });
  }
});


module.exports = router;

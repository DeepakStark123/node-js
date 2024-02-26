const express = require("express");
const path = require("path")
const app = express();
log = console.log
app.listen(4500);
publicDir = path.join(__dirname,"public")
app.set("view engine","ejs");


//--profile-page--
// app.get("/profile",(_,res)=>{
//     const user = {
//         'name':'deepak',
//         'userid':100,
//         'position':'flutter developer',
//         'skills':['fluter','python','nodejs','c++']
//     }
//   res.render("profile",{user});
// });


//--login-page--
app.get("/login",(_,res)=>{
    res.render("login");
});
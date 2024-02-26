const express = require("express");
const path = require("path")
const app = express();
log = console.log
app.listen(4500);
publicDir = path.join(__dirname,"public")

///--send-home--
app.get("",(req,res)=>{
  res.sendFile(`${publicDir}/home.html`)
});

///--send-about--
app.get("/aboutus",(req,res)=>{
    res.sendFile(`${publicDir}/about.html`)
  });

///--send-contact--
app.get("/contact",(req,res)=>{
    res.sendFile(`${publicDir}/contact.html`)
  });

///--send-page-not-found--
app.get("*",(req,res)=>{
    res.sendFile(`${publicDir}/page_not_found.html`)
  });

  
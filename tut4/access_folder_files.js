const express = require("express");
const path = require("path")
const app = express();
log = console.log
app.listen(4500);
publicDir = path.join(__dirname,"public")
app.use(express.static(publicDir));  ///help to excess folder and its all file


// we can use the url "http://localhost:4500/contact.html" to get the contact.hmtl page



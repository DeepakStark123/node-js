const express = require('express');
const app = express();
const multer  = require('multer')
app.listen(4500); 

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'upload')
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
    cb(null, file.fieldname + '-' + uniqueSuffix+'.png')
  }
});

const upload = multer({ storage: storage }).single('user_file');

//---upload-file---
app.post('/upload',upload,(req,resp)=>{
  try {
    resp.send("File Uploaded Successfully");
  } catch (e) {
    console.error(e);
    resp.status(404).send("Not Found");
    resp.status(500).send("Internal Server Error");
  }
})

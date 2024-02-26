const fs = require("fs")
const path = require("path")
var curd_dir = path.join(__dirname,"file_system_curd");
var filepath = curd_dir+"/apple.txt";
var newfilepath = curd_dir+"/fruit.txt";
var log = console.log
log(filepath)


//----create-new-file----
// s.writeFileSync(filepath,"hello how are you deepak")

////---red-file-content--
// fs.readFile(filepath,"utf8",(err,item)=>{
//     log(item);
// })

////---Append-Text-In-File----
// fs.appendFile(filepath ,"append this text in apple.txt file",(err)=>{
//     if(!err) log("File Updated")
// })

////--Chnage-File-Name-----
// fs.rename(filepath,newfilepath,(err)=>{
//     if(!err) log("File Name Chnaged")
// })

////---Delete--File----
// fs.unlinkSync(newfilepath); 
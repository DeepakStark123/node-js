const path = require("path")
const fs = require("fs")
var dir = path.join(__dirname,"files")


// for(i=0;i<3;i++){
//    fs.writeFileSync(dir+'/apple'+i+'.txt',"This si appple")
// }


fs.readdir(dir,(err,files)=>{
    files.forEach((element) => {
        console.log("file name is: "+element)
    });
})
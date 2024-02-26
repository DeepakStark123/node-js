// /////----case-1-----
// var a = 10
// var b = 10

// if(a==b){
//     console.log("Same");
// }else{
//     console.log("Not Same");
// }

// ////output => Same
// //// in case-1 output is not same becuase "==" compare only identity value does not depend on data type of variable.

// ////----case-2-----
// var x = 10
// var y = "10"

// if(x===y){
//     console.log("Same");
// }else{
//     console.log("Not Same");
// }

// ////output => Not Same 
// //// in case-2 output is not same becuase "===" compare the value as well as data type of variable also.


// ////-------------For Loop / if-else------

// var n = 5;
// for(var i =0;i<n;i++){
//     if(i%2){
//         console.log("i=",i)
//     }
// }

// ////---------Array--------
// var arr = [2.4,6,10]
// //// console.log(arr)
// console.log(arr[2])


////---------Export-Vriable-From-Another-File----------------

// const app = require("./app")
// console.log("x=",app.x);
// console.log("y=",app.y);
// console.log("sum=",app.z(30,40));
// var result = app.arr.filter((item)=>{
//     return item%2;
// })
// console.log(result);


////---------File-System----------------
fs = require("fs");
fs.writeFileSync("hello.txt","Deepak Kumar") // create a file hello.txt
console.log("current directory=",__dirname) // give the current directory  
console.log("current directory=",__filename) // give the current working file  

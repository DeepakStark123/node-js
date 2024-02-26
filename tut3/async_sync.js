var log = console.log;
//------
// log("first")
// setTimeout(()=>{
//     log("second")
// },2000)
// log("third")

//------
// x=10
// y=0

// setTimeout(()=>{
//     y=20
// },2000)

// log("x+y="+(x+y))

// //------
// x=10
// y=0

// var waitingData = new Promise((resolve,reject)=>{
//     setTimeout(()=>{
//       resolve(30)
//     },2000)
// })

// waitingData.then((val)=>{
//     log(x+val)
// })

//--------------

//------
log("first");  // Executed-1

setTimeout(() => {
  log("second after 2 sec");  // Executed-4
}, 2000);

setTimeout(() => {
  log("third after 0 second") // Executed-3
}, 0);


log("fourth"); // Executed-2

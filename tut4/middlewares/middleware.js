module.exports = {
    myMiddleWare : resFilter = (req,res,next)=>{
        var age = req.query.age;
       //check age of user
       if(!age){
           res.send("Please provide your age")
       }else if(age<18){
           res.send("This site is only for 18+")
       }else{
          next();
       }
   }
}
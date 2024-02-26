const dbConnect = require("./mongodb");
var log = console.log;

//-----INSERT-OPERATION----
const insertOperation = async () => {
  const db = await dbConnect();
  // for insert one we use 'insertOne' and for many user 'insertMany'
  const result = await db.insertMany([
    {
      name: "mi x1",
      brand: "Redme",
      price: 13000,
      category: "mobile",
    },
    {
      name: "vivo++",
      brand: "Vivo",
      price: 18000,
      category: "mobile",
    },
  ]);
  log(result);
  if(result.acknowledged){
    log(`${result.deletedCount} data inserted successfully`);
  }
};
// insertOperation();

//-----Update-OPERATION----
const updateOperation = async () => {
  const db = await dbConnect();
  // for update one we use 'updateOne' and for many user 'updateMany'
  const result = await db.updateOne(
    {name: "mi x1"},{
      $set : {
        price: 15000,
       },
    }
  );

  log(result);
  if(result.acknowledged){
    log(`${result.deletedCount} data updated successfully`);
  }

};
// updateOperation();

//-----Delete-OPERATION----
const deteteOperation = async () => {
  const db = await dbConnect();
  const result = await db.deleteOne(
    {name: "vivo++"}
  );
  log(result);
  if(result.acknowledged){
    log(`${result.deletedCount} data deleted successfully`);
  }
};

// deteteOperation();
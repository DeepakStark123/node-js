require("./config");
const productModel = require("./product_model");
log = console.log;

//---Insert-using-mongoose---
const insertInDb = async () => {
  var data = productModel({
    name: "iphone-16",
    price: 2000,
    brand: "Apple",
    category: "mobile",
  });
  var result = await data.save();
  log(result);
};

// insertInDb();

//---Update-using-mongoose---
const updateInDb = async () => {
  var result = await productModel.updateMany(
    {
      name: "iphone-16",
    },
    {
      $set: {
        price: 130000,
      },
    }
  );
  log(result);
};

// updateInDb();

//---Delete-using-mongoose---
const deleteInDb = async () => {
  var result = await productModel.deleteMany({
    name: "iphone-16",
  });
  log(result);
};

deleteInDb();

//---Find-using-mongoose---
const findInDb = async () => {
    var result = await productModel.find({
      name: "iphone 17 pro",
    });
    log(result);
  };

//   findInDb();

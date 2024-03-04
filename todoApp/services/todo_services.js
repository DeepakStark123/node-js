const { deleteToDo } = require("../controller/todo_controller");
const ToDoModel = require("../models/todo_model");

class ToDoService {
  static async createToDo(userId, title, description) {
    const createToDo = new ToDoModel({ userId, title, description });
    return await createToDo.save();
  }

  static async getUserToDoList(userId) {
    const todoList = await ToDoModel.find({ userId });
    return todoList;
  }

  static async deleteToDo(id) {
    const deleted = await ToDoModel.findByIdAndDelete({ _id: id });
    return deleted;
  }

  //----Check-User-Exist-Or-Not--ById--
  static async checkToDoById(todoId) {
    try {
     // Find the to-do item by ID
     const todo = await ToDoModel.findById(todoId);
     if (todo) {
         console.log("Item exists:", todo);
         return true;
     } else {
         console.log("Item does not exist");
         return false;
     }
    } catch (error) {
      console.error("Error checking todo item ID:", error);
      return false;
    }
  }
}

module.exports = ToDoService;

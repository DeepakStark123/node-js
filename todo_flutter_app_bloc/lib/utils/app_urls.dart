class AppUrls {
  static const baseUrl = 'http://192.168.2.32:4500/'; //Aphroecs
  // static const baseUrl = "http://192.168.23.93:4500/"; //Narzo-50-5G
  // static const baseUrl = "http://192.168.0.106:4500/"; //Home-Wifi
  // static const baseUrl = "http://192.168.153.93:4500/"; //Moto-Wifi
  static const registration = "${baseUrl}register";
  static const loginApi = '${baseUrl}login';
  static const addtodo = '${baseUrl}createToDo';
  static const getToDoList = '${baseUrl}getUserTodoList';
  static const deleteTodo = '${baseUrl}deleteTodo';
}

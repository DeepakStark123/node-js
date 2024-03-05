// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import '../controllers/home_controller.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({required this.token, Key? key}) : super(key: key);
//   final String token;

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   HomeController homeController = Get.put(HomeController());

//   @override
//   void initState() {
//     homeController.getData(widget.token);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlueAccent,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.only(
//                 top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 30.0,
//                   child: Icon(
//                     Icons.list,
//                     size: 30.0,
//                   ),
//                 ),
//                 const SizedBox(height: 10.0),
//                 const Text(
//                   'Flutter-Nodejs-MongoDb-TodoApp',
//                   style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 8.0),
//                 Obx(
//                   () => Text(
//                     '${homeController.items?.length ?? 0} Task',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: Obx(
//                 () => Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: homeController.items == null
//                       ? null
//                       : homeController.items!.isEmpty
//                           ? const Center(
//                               child: Text(
//                                 "No Items",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             )
//                           : ListView.builder(
//                               itemCount: homeController.items!.length,
//                               itemBuilder: (context, int index) {
//                                 return Dismissible(
//                                   key:
//                                       UniqueKey(), // Provide a unique key for each item
//                                   onDismissed: (direction) {
//                                     // Handle dismissal action here
//                                     if (direction ==
//                                         DismissDirection.startToEnd) {
//                                       // Handle left to right swipe (if needed)
//                                     } else if (direction ==
//                                         DismissDirection.endToStart) {
//                                       // Handle right to left swipe (delete action)
//                                       homeController.deleteItem(
//                                           '${homeController.items![index]['_id']}');
//                                     }
//                                   },
//                                   background: Container(
//                                     color: Colors.green,
//                                     alignment: Alignment.centerLeft,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20),
//                                     child: const Icon(Icons.archive,
//                                         color: Colors.white),
//                                   ),
//                                   secondaryBackground: Container(
//                                     color: Colors.red,
//                                     alignment: Alignment.centerRight,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20),
//                                     child: const Icon(Icons.delete,
//                                         color: Colors.white),
//                                   ),
//                                   child: Slidable(
//                                     key: const ValueKey(0),
//                                     endActionPane: ActionPane(
//                                       motion: const ScrollMotion(),
//                                       dismissible:
//                                           DismissiblePane(onDismissed: () {}),
//                                       children: [
//                                         SlidableAction(
//                                           backgroundColor:
//                                               const Color(0xFFFE4A49),
//                                           foregroundColor: Colors.white,
//                                           icon: Icons.delete,
//                                           label: 'Delete',
//                                           onPressed: (BuildContext context) {
//                                             homeController.deleteItem(
//                                                 '${homeController.items![index]['_id']}');
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                     child: Card(
//                                       borderOnForeground: false,
//                                       child: ListTile(
//                                         leading: const Icon(Icons.task),
//                                         title: Text(
//                                             '${homeController.items![index]['title']}'),
//                                         subtitle: Text(
//                                             '${homeController.items![index]['description']}'),
//                                         trailing: const Icon(Icons.arrow_back),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                                 // Slidable(
//                                 //   key: const ValueKey(0),
//                                 //   endActionPane: ActionPane(
//                                 //     motion: const ScrollMotion(),
//                                 //     dismissible:
//                                 //         DismissiblePane(onDismissed: () {}),
//                                 //     children: [
//                                 //       SlidableAction(
//                                 //         backgroundColor:
//                                 //             const Color(0xFFFE4A49),
//                                 //         foregroundColor: Colors.white,
//                                 //         icon: Icons.delete,
//                                 //         label: 'Delete',
//                                 //         onPressed: (BuildContext context) {
//                                 //           homeController.deleteItem(
//                                 //               '${homeController.items![index]['_id']}');
//                                 //         },
//                                 //       ),
//                                 //     ],
//                                 //   ),
//                                 //   child: Card(
//                                 //     borderOnForeground: false,
//                                 //     child: ListTile(
//                                 //       leading: const Icon(Icons.task),
//                                 //       title: Text(
//                                 //           '${homeController.items![index]['title']}'),
//                                 //       subtitle: Text(
//                                 //           '${homeController.items![index]['description']}'),
//                                 //       trailing: const Icon(Icons.arrow_back),
//                                 //     ),
//                                 //   ),
//                                 // );
//                               },
//                             ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => homeController.displayTextInputDialog(context),
//         tooltip: 'Add-ToDo',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

//---------

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.token, Key? key}) : super(key: key);
  final String token;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.getData(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: Icon(
                    Icons.list,
                    size: 30.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Flutter-Nodejs-MongoDb-TodoApp',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8.0),
                Obx(
                  () => Text(
                    '${homeController.items?.length ?? 0} Task',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: homeController.items == null
                      ? null
                      : homeController.items!.isEmpty
                          ? const Center(
                              child: Text(
                                "No Items",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: homeController.items!.length,
                              itemBuilder: (context, int index) {
                                return Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    dismissible:
                                        DismissiblePane(onDismissed: () {
                                      homeController.deleteItem(
                                          '${homeController.items![index]['_id']}');
                                    }),
                                    children: [
                                      SlidableAction(
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                        onPressed: (BuildContext context) {
                                          homeController.deleteItem(
                                              '${homeController.items![index]['_id']}');
                                        },
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    borderOnForeground: false,
                                    child: ListTile(
                                      leading: const Icon(Icons.task),
                                      title: Text(
                                          '${homeController.items![index]['title']}'),
                                      subtitle: Text(
                                          '${homeController.items![index]['description']}'),
                                      trailing: const Icon(Icons.arrow_back),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => homeController.displayTextInputDialog(context),
        tooltip: 'Add-ToDo',
        child: const Icon(Icons.add),
      ),
    );
  }
}

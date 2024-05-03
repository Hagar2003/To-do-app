//import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/addtask.dart';
import 'package:todoapp/editnode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('Tasks');
  runApp(const ToDoApp());
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final t = Hive.box('Tasks');
  final tt = TextEditingController();
  final kt = TextEditingController();
  bool x = false;
  List<Map<String, dynamic>> data = [];
  GlobalKey<ScaffoldState> sdkey = GlobalKey<ScaffoldState>();
  void get() {
    setState(() {
      data = t.keys.map((e) {
        final c = t.get(e);
        return {
          'key': e,
          'title': c['title'],
          'description': c['description'],
        };
      }).toList();
    });
    debugPrint("task length is:${data.length}");
  }

  Future<void> add({required String title, required String description}) async {
    await t.add({'title': title, 'description': description});
    get();
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  void delete({required int keyy}) async {
    await t.delete(keyy);
    get();
  }

  bool open = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: sdkey,
          appBar: AppBar(
            title: const Text("   ToDo APP",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 230, 159, 243),
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:
                  (context) => ADDTASK()));
                  },
                // onPressed: (){setState(() {
                //   Navigator.push(context, MaterialPageRoute(builder:
                //  (context) => ADDTASK()));
                //});

              //   sdkey.currentState!.showBottomSheet(
              //     (context) {
              //       return Container(
              //         padding: const EdgeInsets.symmetric(
              //             vertical: 15, horizontal: 12),
              //         child: Column(
              //           children: [
              //             const SizedBox(height: 30),
              //             TextField(
              //               controller: tt,
              //               decoration: const InputDecoration(
              //                 hintText: 'Title',
              //                 //  border:UnderLineInputBorder()
              //               ),
              //             ),
              //             const SizedBox(height: 20),
              //             TextField(
              //               controller: kt,
              //               decoration: const InputDecoration(
              //                 hintText: 'description',
              //                 //  border:UnderLineInputBorder()
              //               ),
              //             ),
              //             const SizedBox(height: 30),
              //             MaterialButton(
              //               onPressed: () {
              //                 if (tt.text.isNotEmpty && kt.text.isNotEmpty) {
              //                   add(title: tt.text, description: kt.text);
              //                   Navigator.pop(context);
              //                 }
              //               },
              //               color: const Color.fromARGB(255, 228, 145, 243),
              //               textColor: Colors.white,
              //               child: const Text(' Add Task ',
              //                   style: TextStyle(
              //                       fontSize: 17, fontWeight: FontWeight.bold)),
              //             )
              //           ],
              //         ),
              //       );
              //       //   });
              //     },
              //   );
              // },
              child: const Icon(Icons.add),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 145, 243),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              Text(
                                data[index]['title'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(data[index]['description'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  )),
                            ]),
                            const SizedBox(
                              width: 150,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Edit(
                                            title: data[index]['title'],
                                            description: data[index]
                                                ['description'],
                                            kkey: data[index]['key']);
                                      }));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      delete(keyy: data[index]['key']);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 30,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        x = !x;
                                      });
                                    },
                                    child: Icon(
                                      Icons.check_circle_outline_outlined,
                                      color:
                                          x ? Colors.deepPurple : Colors.white,
                                      size: 30,
                                    )),
                              ],
                            )
                          ]));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
              )),
        ));
  }
}

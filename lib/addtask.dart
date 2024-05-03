import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/main.dart';

class ADDTASK extends StatefulWidget {
  ADDTASK({
    super.key,
  });

  State<ADDTASK> createState() => _ADDTASKState();
}

class _ADDTASKState extends State<ADDTASK> {
  final tt = TextEditingController();

  final kt = TextEditingController();

  final t = Hive.box('Tasks');

  List<Map<String, dynamic>> data = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("   Add task",
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 230, 159, 243),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: tt,
              decoration: const InputDecoration(
                hintText: 'Title',
                //  border:UnderLineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: kt,
              decoration: InputDecoration(
                hintText: 'description',
                //  border:UnderLineInputBorder()
              ),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              onPressed: () {
                setState(() {
                  if (tt.text.isNotEmpty && kt.text.isNotEmpty) {
                    add(title: tt.text, description: kt.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ToDoApp()));
                  }
                });
              },
              color: const Color.fromARGB(255, 228, 145, 243),
              textColor: Colors.white,
              child: const Text(' Add Task ',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}

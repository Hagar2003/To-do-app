import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/main.dart';

class Edit extends StatefulWidget {
  String title;
  String description;
  int kkey;
  Edit(
      {super.key,
      required this.title,
      required this.description,
      required this.kkey});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final tsco = TextEditingController();

  final decon = TextEditingController();

  final t = Hive.box('Tasks');

  void update() {
    t.put(widget.kkey, {
      'title': tsco.text,
      'description': decon.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("   Edit",
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 230, 159, 243),
      ),
      body: Column(children: [
        TextField(
          controller: tsco,
          decoration: InputDecoration(
            hintText: '  Editedtitle',
            //border: InputBorder.none,
          ),
        ),
        SizedBox(height: 15),
        TextField(
          controller: decon,
          decoration: InputDecoration(
            hintText: ' Editdescription',
            //border: InputBorder.none,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        MaterialButton(
          onPressed: () {
            
          
            if (tsco.text != widget.title || decon.text != widget.description) {
              update();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ToDoApp()));
            }
          },
          color: const Color.fromARGB(255, 228, 145, 243),
          textColor: Colors.white,
          child: const Text(' Edit ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        )
      ]),
    );
  }
}

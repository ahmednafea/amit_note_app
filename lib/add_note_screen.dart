import 'package:flutter/material.dart';
import 'package:note_app/db_manager.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddNoteScreenState();
  }
}

class AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleTEC = TextEditingController(),
      descriptionTEC = TextEditingController();

  addNote(String title, String description) async {
    var dataBase = await DBManager().db;
    var res = await dataBase!.rawInsert(
      'INSERT INTO Notes(title, description) VALUES("$title", "$description")',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Column(
        children: [
          TextField(controller: titleTEC),
          TextField(controller: descriptionTEC),
          ElevatedButton(
            onPressed: () async {
              if (titleTEC.value.text.isNotEmpty &&
                  descriptionTEC.value.text.isNotEmpty) {
                await addNote(titleTEC.value.text, descriptionTEC.value.text);
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}

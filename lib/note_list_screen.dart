import 'package:flutter/material.dart';
import 'package:note_app/db_manager.dart';
import 'package:note_app/note_model.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return NoteListScreenState();
  }
}

class NoteListScreenState extends State<NoteListScreen> {
  DBManager db = DBManager();
  List<NoteModel> notes = [];

  @override
  void initState() {
    super.initState();
    addNote();
    loadNotes();
  }

  loadNotes() async {
    var dataBase = await db.db;
    var res = await dataBase!.rawQuery("SELECT * FROM Notes");
    setState(() {
      notes = res.map((val) => NoteModel.fromMap(val)).toList();
    });
  }

  addNote() async {
    var dataBase = await db.db;
    var res = await dataBase!.rawInsert(
      'INSERT INTO Notes(title, description) VALUES("Note Title", "Hello Guys")',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          notes.isEmpty
              ? Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              )
              : ListView(children: notes.map((val)=>Text(val.title)).toList(),),
    );
  }
}

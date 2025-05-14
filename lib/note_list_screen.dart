import 'package:flutter/material.dart';
import 'package:note_app/add_note_screen.dart';
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
    loadNotes();
  }

  loadNotes() async {
    var dataBase = await db.db;
    var res = await dataBase!.rawQuery("SELECT * FROM Notes");
    setState(() {
      notes = res.map((val) => NoteModel.fromMap(val)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
        child: Icon(Icons.add),
      ),
      body:
          notes.isEmpty
              ? Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              )
              : ListView(
                padding: EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  top: MediaQuery.of(context).padding.top,
                ),
                children:
                    notes
                        .map(
                          (note) => Card(
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Note Title: ${note.title}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          note.description,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
    );
  }
}

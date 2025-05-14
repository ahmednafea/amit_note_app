import 'package:flutter/material.dart';
import 'package:note_app/db_manager.dart';
import 'package:note_app/note_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBManager myDB = DBManager();
  await myDB.db;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: NoteListScreen(),
    );
  }
}

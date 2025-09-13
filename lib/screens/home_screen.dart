import 'package:flutter/material.dart';
import '../components/note_card.dart';
import '../constants/colors.dart';
import '../data/note_database.dart';
import '../data/note_model.dart';
import 'add_edit_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> noteList = [];
  var noteDatabase = NoteDatabase();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    setState(() {
      noteList = noteDatabase.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!', style: TextStyle(color: Colors.white)),
        backgroundColor: mainColor,
      ),
      body: ListView.builder(
        itemCount: noteList.length,
        itemBuilder: (context, index) {
          final note = noteList[index];
          return NoteCard(
            note: note,
            cardColor: noteColors[index % noteColors.length],
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AddEditNoteScreen(note: note, noteIndex: index),
                ),
              );
              if (result == true) _loadNotes();
            },
            onDelete: () {
              setState(() {
                noteDatabase.deleteNote(index);
                _loadNotes();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditNoteScreen()),
          );
          if (result == true) _loadNotes();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../constants/colors.dart';
import '../data/note_database.dart';
import '../data/note_model.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;
  final int? noteIndex;

  const AddEditNoteScreen({this.note, this.noteIndex, super.key});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final date = DateTime.now().toIso8601String();

    final note = Note(title: title, content: content, date: date);

    var noteDatabase = NoteDatabase();

    if (widget.note == null) {
      noteDatabase.addNote(note);
    } else {
      noteDatabase.updateNote(widget.noteIndex!, note); 
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'Add Note'),
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(label: 'Title', controller: _titleController),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Content',
                controller: _contentController,
                maxLines: 6,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: isEditing ? 'Update Note' : 'Save Note',
                onPressed: _saveNote,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

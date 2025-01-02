import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../models/note.dart';

class AddNoteScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  AddNoteScreen({super.key});

  void _addNote(BuildContext context) {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      Provider.of<NoteProvider>(context, listen: false).addNote(
        Note(
          id: DateTime.now().toString(),
          title: title,
          content: content,
          updatedAt: DateTime.now(),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Note Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Note Content'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
           ElevatedButton(
  onPressed: () => _addNote(context),
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 48, 56, 46), // Text color
  ),
  child: const Text('Add Note'),
)

          ],
        ),
      ),
    );
  }
}

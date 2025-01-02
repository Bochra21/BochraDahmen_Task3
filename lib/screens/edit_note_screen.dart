import 'package:flutter/material.dart';
import 'package:miniprojet/providers/note_provider.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';

class EditNoteScreen extends StatelessWidget {
  final Note note;

  const EditNoteScreen({required this.note, super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
  ElevatedButton(
  onPressed: () {
    final updatedNote = Note(
      id: note.id,
      title: titleController.text,
      content: contentController.text,
      updatedAt: DateTime.now(),
    );
    context.read<NoteProvider>().updateNote(updatedNote);
    Navigator.pop(context);
  },
  style: ElevatedButton.styleFrom(
    foregroundColor:const Color.fromARGB(255,247, 243, 243), backgroundColor:const Color.fromARGB(255, 112, 96, 92), 
  ),
  child: const Text('Save Changes'),
)


          ],
        ),
      ),
    );
  }
}
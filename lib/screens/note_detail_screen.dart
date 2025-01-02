import 'package:flutter/material.dart';
import 'package:miniprojet/providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteDetailScreen extends StatelessWidget {
  final String noteId;

  const NoteDetailScreen({required this.noteId});

  @override
  Widget build(BuildContext context) {
    final note = Provider.of<NoteProvider>(context, listen: false).getNoteById(noteId);

    if (note == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Note Details'),
        ),
        body: const Center(
          child: Text('Note not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              note.content,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Last Updated: ${note.updatedAt}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

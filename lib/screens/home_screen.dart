import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miniprojet/providers/auth_provider.dart';
import 'package:miniprojet/providers/note_provider.dart';
import 'package:miniprojet/widgets/note_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteProvider>(context).notes;

    return Scaffold(
       appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color:Colors.white),
            onPressed: () async {
              await context.read<AuthProvider>().signOut();
              // ignore: use_build_context_synchronously
              context.go('/');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (ctx, index) {
          final note = notes[index];
          return NoteTile(
            title: note.title,
            content: note.content,
            onView: () {
              context.push('/view-note/${note.id}');
            },
            onEdit: () {
              context.push('/edit-note/${note.id}');
            },
            onDelete: () {
              Provider.of<NoteProvider>(context, listen: false).deleteNote(note.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-note');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

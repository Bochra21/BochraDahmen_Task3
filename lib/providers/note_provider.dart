import 'package:flutter/foundation.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  
  List<Note> get notes {
    _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt)); 
    return [..._notes];
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

 void updateNote(Note updatedNote) {
  final index = _notes.indexWhere((note) => note.id == updatedNote.id);
  if (index != -1) {
    _notes[index] = updatedNote;
    notifyListeners();
  }
}

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }


  Note? getNoteById(String id) {
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null; // Return null if no note with that id is found
    }
  }

  // Method to fetch notes (for example, from a local database or API)
  Future<void> fetchNotes() async {
    // Example: fetch notes from a database or API
    // _notes = await someDataSource.fetchNotes();
    notifyListeners();
  }
}

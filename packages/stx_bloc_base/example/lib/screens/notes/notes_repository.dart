import 'dart:async';
import 'dart:io';

import 'package:example/helpers/list_extentions.dart';
import 'package:example/screens/notes/models/models.dart';

class NotesRepository {
  static bool isSuccess = true;

  static List<Note> initalNotes = [
    const Note(noteId: 1, message: 'First'),
    const Note(noteId: 2, message: 'Second'),
  ];

  Future<List<Note>> getNotes() {
    if ((isSuccess = !isSuccess) == false) {
      return Future.value([...initalNotes]);
    }

    throw const HttpException('Get notes failed');
  }

  Future<Note> addNote(Note note) {
    initalNotes.add(note);
    return Future.value(note);
  }

  Future<Note> updateNote(Note note) {
    if ((isSuccess = !isSuccess) == false) {
      initalNotes.replaceWhere(
          (item) => item.noteId == note.noteId, (_) => note, false);
      return Future.value(note);
    }

    throw const HttpException('Get notes failed');
  }

  Future<bool> deleteNote(int id) async {
    final noteToDelete = initalNotes.firstWhere((note) => note.noteId == id);
    initalNotes.remove(noteToDelete);

    return isSuccess = !isSuccess;
  }
}

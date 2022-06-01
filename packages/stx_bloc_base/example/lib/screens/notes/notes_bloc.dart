import 'package:example/helpers/error_handler.dart';
import 'package:example/screens/notes/models/models.dart';
import 'package:example/screens/notes/notes_repository.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

class NotesBloc extends NetworkListBlocBase<Note, NetworkListStateBase<Note>> {
  NotesBloc({
    required this.repository,
  }) : super(
          NetworkListStateBase(),
          errorHandler: ErrorHandler.parse,
        );

  final NotesRepository repository;

  @override
  Future<List<Note>> onLoadDataAsync() {
    return repository.getNotes();
  }

  @override
  Future<Note> onAddItemAsync(Note newItem) {
    return repository.addNote(newItem);
  }

  @override
  Future<Note> onEditItemAsync(Note updatedItem) {
    return repository.updateNote(updatedItem);
  }

  @override
  Future<bool> onDeleteItemAsync(Note item) {
    return repository.deleteNote(item.noteId);
  }

  @override
  bool equals(Note item1, Note item2) {
    return item1.noteId == item2.noteId;
  }
}

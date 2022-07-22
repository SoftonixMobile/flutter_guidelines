import 'package:injectable/injectable.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

import 'models/models.dart';
import 'notes_repository.dart';

@injectable
class NotesBloc
    extends NetworkSearchableListBloc<Note, NetworkSearchableListState<Note>> {
  NotesBloc(this.repository) : super(NetworkSearchableListState());

  final NotesRepository repository;

  @override
  Future<List<Note>> onLoadDataAsync() {
    return repository.getNotes();
  }

  @override
  bool equals(Note item1, Note item2) {
    return item1.id == item2.id;
  }

  @override
  NetworkSearchableListState<Note> onStateChanged(
      NetworkEventBase event, NetworkSearchableListState<Note> state) {
    final query = state.query;

    var visibleData = state.data;

    if (query != null && query.isNotEmpty) {
      visibleData =
          visibleData.where((item) => item.name.contains(query)).toList();
    }

    return state.copyWith(visibleData: visibleData);
  }
}

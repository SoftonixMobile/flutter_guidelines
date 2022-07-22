import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/services/http/http_client.dart';
import 'models/models.dart';

@injectable
class NotesRepository {
  NotesRepository(this.httpClient);

  final HttpClient httpClient;

  Future<List<Note>> getNotes() async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      10,
      (index) => Note(id: index, name: 'Note $index'),
    );
  }
}

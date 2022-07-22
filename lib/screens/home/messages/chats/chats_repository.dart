import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/services/http/http_client.dart';
import 'models/models.dart';

@injectable
class ChatsRepository {
  ChatsRepository(this.httpClient);

  final HttpClient httpClient;

  Future<List<Chat>> getChats() async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      10,
      (index) => Chat(id: index, name: 'Chat $index'),
    );
  }
}

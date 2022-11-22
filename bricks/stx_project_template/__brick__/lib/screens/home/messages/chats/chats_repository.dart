import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/services/http/http_client.dart';
import 'models/models.dart';

@injectable
class ChatsRepository {
  ChatsRepository(this.httpClient);

  final HttpClient httpClient;

  Future<List<Chat>> getChats() async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(
      100,
      (index) => Chat(id: index, name: 'Chat $index'),
    );
  }
}

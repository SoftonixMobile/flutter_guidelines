import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/models/index.dart';

@injectable
class ChatsRepository {
  ChatsRepository();

  Future<List<Chat>> getChats() async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(
      100,
      (index) => Chat(id: index, name: 'Chat $index'),
    );
  }
}

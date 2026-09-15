import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/models/index.dart';

@injectable
class ChatsRepository {
  Future<List<Chat>> getChats() async {
    await Future.delayed(const Duration(seconds: 1));

    return .generate(
      100,
      (index) => Chat(id: index, name: 'Chat $index'),
    );
  }
}

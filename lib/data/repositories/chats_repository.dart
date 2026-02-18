import 'dart:async';

import 'package:data_provider/data_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

@lazySingleton
class ChatsRepository extends ListRepositoryBase<Chat> {
  final ChatsService _chatsService;

  ChatsRepository(this._chatsService);

  FutureOr<List<Chat>> getChats() {
    return load(_chatsService.getAll);
  }

  @override
  bool equals(Chat item1, Chat item2) {
    return item1.id == item2.id;
  }
}

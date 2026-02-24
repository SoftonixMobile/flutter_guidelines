import 'dart:async';

import 'package:data_provider/data_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

@lazySingleton
class ChatsRepository extends ListRepositoryBase<Chat> {
  final ChatsService _chatsService;

  ChatsRepository(this._chatsService);

  FutureOr<List<Chat>> getChats({bool refreshData = false}) {
    return load(_chatsService.getAllChats, refresh: refreshData);
  }

  @override
  bool equals(Chat item1, Chat item2) {
    return item1.id == item2.id;
  }
}

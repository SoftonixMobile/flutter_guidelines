import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';

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

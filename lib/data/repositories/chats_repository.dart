import 'package:data_provider/data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatsRepository extends Cubit<List<Chat>> {
  final ChatsService _chatsService;

  ChatsRepository(this._chatsService) : super([]);

  Future<List<Chat>> getChats() async {
    final chats = await _chatsService.getChats();

    emit(chats);

    return chats;
  }

  @override
  @disposeMethod
  Future<void> close() {
    return super.close();
  }
}

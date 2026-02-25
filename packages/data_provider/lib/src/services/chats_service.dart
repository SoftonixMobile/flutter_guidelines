import 'package:injectable/injectable.dart';

import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';

@injectable
class ChatsService {
  final ApiClient _client;

  ChatsService(this._client) {
    _client.registerType(Chat.fromJson);
  }

  Future<List<Chat>> getAllChats() async {
    return _client.getData<List<Chat>>('/chats');
  }

  Future<Chat> getChatById(int id) async {
    return _client.getData<Chat>('/chats/$id');
  }
}

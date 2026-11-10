import 'package:api_client/api_client.dart';
import 'package:app_api/models.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatsService(final ApiClient _client) {
  this {
    _client.registerType(Chat.fromJson);
  }

  Future<List<Chat>> getAllChats() {
    return _client.getData<List<Chat>>('/chats');
  }

  Future<Chat> getChatById(int id) {
    return _client.getData<Chat>('/chats/$id');
  }
}

import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
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

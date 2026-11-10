import 'package:api_client/api_client.dart';
import 'package:app_api/models.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatsService(final ApiClient _client) {
  this {
    _client.registerType(ChatDto.fromJson);
  }

  Future<List<ChatDto>> getAllChats() {
    return _client.getData<List<ChatDto>>('/chats');
  }

  Future<ChatDto> getChatById(int id) {
    return _client.getData<ChatDto>('/chats/$id');
  }
}

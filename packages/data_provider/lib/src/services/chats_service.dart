import 'package:injectable/injectable.dart';

import '../network/network_base_client.dart';
import '../../models.dart';

@injectable
class ChatsService {
  final NetworkBaseClient _network;

  ChatsService(this._network);

  Future<List<Chat>> getChats() async {
    final response = await _network.get('/chats');
    return (response.data as List).map((json) => Chat.fromJson(json)).toList();
  }

  Future<Chat> getChat(int id) async {
    final response = await _network.get('/chats/$id');
    return Chat.fromJson(response.data);
  }
}

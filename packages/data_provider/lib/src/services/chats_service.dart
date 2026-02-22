import 'package:injectable/injectable.dart';

import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';

@injectable
class ChatsService {
  final NetworkBaseClient _network;

  ChatsService(this._network) {
    _network.registerType(Chat.fromJson);
  }

  Future<List<Chat>> getAllChats() async {
    return _network.getData<List<Chat>>('/chats');
  }

  Future<Chat> getChatById(int id) async {
    return _network.getData<Chat>('/chats/$id');
  }
}

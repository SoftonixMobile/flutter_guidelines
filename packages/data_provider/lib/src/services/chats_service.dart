import 'package:injectable/injectable.dart';

import '../network/network_base_client.dart';
import '../../models.dart';

@injectable
class ChatsService {
  final NetworkBaseClient _network;

  ChatsService(this._network) {
    _network.registerType(Chat.fromJson);
  }

  Future<List<Chat>> getAll() async {
    return _network.getData<List<Chat>>('/chats');
  }

  Future<Chat> getById(int id) async {
    return _network.getData<Chat>('/chats/$id');
  }
}

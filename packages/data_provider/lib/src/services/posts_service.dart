import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostsService {
  final NetworkBaseClient _networkClient;

  PostsService(this._networkClient) {
    _networkClient.registerType(Post.fromJson);
  }

  Future<List<Post>> getPosts() async {
    return _networkClient.getData<List<Post>>(
      'https://jsonplaceholder.typicode.com/posts',
    );
  }
}

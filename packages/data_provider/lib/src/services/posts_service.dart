import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostsService {
  final NetworkBaseClient _networkClient;

  PostsService(this._networkClient);

  Future<List<Post>> getPosts() async {
    final response = await _networkClient.get(
      'https://jsonplaceholder.typicode.com/posts',
    );

    return (response.data as List).map((json) => Post.fromJson(json)).toList();
  }
}

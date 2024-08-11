import 'package:fetch_posts_with_provider/models/call_result.dart';
import 'package:fetch_posts_with_provider/models/post.dart';
import 'package:fetch_posts_with_provider/services/dio_service.dart';

class PostRepository {
  PostRepository();

  Future<CallResult<List<Post>>> getPosts() async {
    try {
      var response = await DioService.dio.get('posts');

      if (response.statusCode == 200) {
        final postsJson = (response.data as List)
            .map<Post>((json) => Post.fromJson(json))
            .toList();
        return CallResult(
          status: response.statusCode!,
          statusMessage: response.statusMessage!,
          data: postsJson,
          isSuscces: true,
          error: '',
        );
      } else {
        return CallResult(
          isSuscces: false,
          status: response.statusCode!,
          statusMessage: response.statusMessage!,
          data: null,
          error: 'Error: ${response.statusCode!}',
        );
      }
    } catch (e) {
      return CallResult(
        isSuscces: false,
        status: 500,
        statusMessage: 'Internal Server Error',
        data: null,
        error: 'Exception: $e',
      );
    }
  }

}

import 'package:fetch_posts_with_provider/models/call_result.dart';
import 'package:fetch_posts_with_provider/models/comment.dart';
import 'package:fetch_posts_with_provider/services/dio_service.dart';

class CommentRepository {
  CommentRepository();

  Future<CallResult<List<Comment>>> getComments(int postId) async {
    try {
      var response = await DioService.dio.get('posts/$postId/comments');

      if (response.statusCode == 200) {
        final commentsJson = (response.data as List)
            .map<Comment>((json) => Comment.fromJson(json))
            .toList();
        return CallResult(
          status: response.statusCode!,
          statusMessage: response.statusMessage!,
          data: commentsJson,
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

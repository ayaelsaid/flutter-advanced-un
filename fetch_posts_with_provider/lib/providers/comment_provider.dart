import 'package:fetch_posts_with_provider/models/comment.dart';
import 'package:fetch_posts_with_provider/repository/fetch_comments.dart';
import 'package:flutter/material.dart';
// import 'package:fetch_posts_with_provider/models/comment.dart';
// import 'package:fetch_posts_with_provider/repository/fetch_comments.dart';
// import 'package:flutter/material.dart';

class CommentProvider with ChangeNotifier {
  final CommentRepository commentRepository;
  List<Comment> _comments = [];
  bool _loading = false;
  String? _error;

  CommentProvider({required this.commentRepository});

  List<Comment> get comments => _comments;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchComments(int postId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await commentRepository.getComments(postId);
      if (result.isSuscces) {
        _comments = result.data!;
        _loading = false;
        notifyListeners();
      } else {
        _loading = false;
        _error = result.error;
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      _error = 'Exception: $e';
      notifyListeners();
    }
  }
}



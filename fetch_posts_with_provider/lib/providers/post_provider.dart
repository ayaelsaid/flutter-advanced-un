import 'package:fetch_posts_with_provider/models/post.dart';
import 'package:fetch_posts_with_provider/repository/posts_repo.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  final PostRepository postRepository;
  List<Post> _posts = [];
  bool _loading = false;
  String? _error;

  PostProvider({required this.postRepository});

  List<Post> get posts => _posts;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchPosts() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await postRepository.getPosts();
      if (result.isSuscces) {
        _posts = result.data!;
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


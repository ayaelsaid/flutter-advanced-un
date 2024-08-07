import 'package:flutter/material.dart';
import 'package:using_api_to_show_posts_comments/widgets/posts.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Posts And Comments',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 23, 121, 201),
        ),
        body: const Posts());
  }
}

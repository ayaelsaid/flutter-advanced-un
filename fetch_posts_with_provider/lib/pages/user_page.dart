import 'package:fetch_posts_with_provider/widgets/post_screen.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

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
        body: const PostScreen());
  }
}
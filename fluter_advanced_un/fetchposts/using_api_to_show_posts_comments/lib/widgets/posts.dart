import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:using_api_to_show_posts_comments/widgets/list_view_coments.dart';
import 'package:using_api_to_show_posts_comments/widgets/listview_posts.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  bool isLoadingPosts = false;
  bool isLoadingComments = false;
  List posts = [];
  List comments = [];
  String postsUri = 'https://jsonplaceholder.typicode.com/posts';
  String commentsUri = 'https://jsonplaceholder.typicode.com/comments';

  Future<void> fetchPosts() async {
    setState(() {
      isLoadingPosts = true;
    });

    var response = await http.get(Uri.parse(postsUri));

    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
        isLoadingPosts = false;
      });
    } else {
      setState(() {
        isLoadingPosts = false;
      });
      print('Fetch Failed');
    }
  }

  Future<void> fetchComments(int postId) async {
    setState(() {
      isLoadingComments = true;
    });

    var response = await http.get(Uri.parse('$commentsUri?postId=$postId'));

    if (response.statusCode == 200) {
      setState(() {
        comments = json.decode(response.body);
        isLoadingComments = false;
      });
      await showCommentsDialog();
    } else {
      setState(() {
        isLoadingComments = false;
      });
      print('Fetch Failed');
    }
  }

  Future<void> showCommentsDialog() async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Comments'),
          content: SizedBox(
            width: double.maxFinite,
            child: isLoadingComments
                ? const Center(child: CircularProgressIndicator())
                : listViewComments(comments)
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: MaterialButton(
            color: Colors.blue[400],
            textColor: Colors.white,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: fetchPosts,
            child: const Text(
              'Show All Posts And Comments',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (isLoadingPosts)
          const Center(child: CircularProgressIndicator())
        else if (posts.isEmpty)
          const Center(child: Text('Press on icon to Show all posts'))
        else
          Expanded(child: viewListPosts(posts, fetchPosts, fetchComments)
              )
      ]),
    );
  }
}

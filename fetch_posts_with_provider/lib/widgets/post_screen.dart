import 'package:fetch_posts_with_provider/providers/post_provider.dart';
import 'package:fetch_posts_with_provider/widgets/comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: MaterialButton(
              color: Colors.blue[400],
              textColor: Colors.white,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () {
                postProvider.fetchPosts();
              },
              child: const Text(
                'Show All Posts And Comments',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: postProvider.loading
                ? const Center(child: CircularProgressIndicator())
                : postProvider.error != null
                    ? Center(child: Text('Error: ${postProvider.error}'))
                    : ListView.builder(
                        itemCount: postProvider.posts.length,
                        itemBuilder: (context, index) {
                          final post = postProvider.posts[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ListTile(
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.title ?? 'No Title',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 23, 121, 201),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                      ]),
                                  subtitle: Text(post.body ?? 'No Body'),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CommentsScreen(postId: post.id!),
                                      );
                                    },
                                    child: const Text('Comments'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

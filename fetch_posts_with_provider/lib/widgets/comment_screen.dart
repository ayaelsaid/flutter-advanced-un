import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fetch_posts_with_provider/providers/comment_provider.dart';

class CommentsScreen extends StatelessWidget {
  final int postId;

  const CommentsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final commentProvider =
        Provider.of<CommentProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      commentProvider.fetchComments(postId);
    });

    return AlertDialog(
      title: const Text('Comments'),
      content: Consumer<CommentProvider>(
        builder: (context, commentProvider, child) {
          return SizedBox(
            width: double.maxFinite,
            child: commentProvider.loading
                ? const Center(child: CircularProgressIndicator())
                : commentProvider.error != null
                    ? Center(child: Text('Error: ${commentProvider.error}'))
                    : ListView.builder(
                        itemCount: commentProvider.comments.length,
                        itemBuilder: (context, index) {
                          final comment = commentProvider.comments[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.name ?? 'NO name',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 23, 121, 201),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                              subtitle: Text(comment.body ?? 'No body'),
                            ),
                          );
                        },
                      ),
          );
        },
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
  }
}

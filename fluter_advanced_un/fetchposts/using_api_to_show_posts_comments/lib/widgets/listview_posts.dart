import 'package:flutter/material.dart';

  Widget viewListPosts(List posts, Function fetchPosts, Function fetchComments) {
    return   ListView(
              children: List.generate(posts.length, (index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              posts[index]['title'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 23, 121, 201)),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                        subtitle: Text(posts[index]['body']),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: TextButton(
                          onPressed: () {
                            fetchComments(posts[index]['id']);
                          },
                          child: const Text('Comments'),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
  }

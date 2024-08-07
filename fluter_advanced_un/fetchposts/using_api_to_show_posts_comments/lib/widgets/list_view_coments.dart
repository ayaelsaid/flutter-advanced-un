import 'package:flutter/material.dart';

Widget listViewComments(List comments) {
  return ListView(
      children: List.generate(comments.length, (index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comments[index]['name'],
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 23, 121, 201)),
            ),
            const SizedBox(height: 8),
          ],
        ),
        subtitle: Text(comments[index]['body']),
      ),
    );
  }));
}

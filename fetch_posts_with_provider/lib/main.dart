import 'package:fetch_posts_with_provider/pages/user_page.dart';
import 'package:fetch_posts_with_provider/providers/comment_provider.dart';
import 'package:fetch_posts_with_provider/providers/post_provider.dart';
import 'package:fetch_posts_with_provider/repository/comments_repo.dart';
import 'package:fetch_posts_with_provider/repository/posts_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PostProvider(postRepository: PostRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              CommentProvider(commentRepository: CommentRepository()),
        ),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserPage(),
    );
  }
}


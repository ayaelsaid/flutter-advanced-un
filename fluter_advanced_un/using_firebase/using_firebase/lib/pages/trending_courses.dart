import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:using_firebase/models/category.dart';
import 'package:using_firebase/models/course.dart';

class TrendingCoursesPage extends StatefulWidget {
  final Category category;

  const TrendingCoursesPage({required this.category, super.key});

  @override
  State<TrendingCoursesPage> createState() => _TrendingCoursesPageState();
}

class _TrendingCoursesPageState extends State<TrendingCoursesPage> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;

  @override
  void initState() {
    super.initState();
    futureCall = FirebaseFirestore.instance
        .collection('courses')
        .where('category', isEqualTo: widget.category.id)
        .where('rank',
            whereIn: ['top rated', 'top search']) // Match ranks exactly
        .orderBy('created_date',
            descending: true) // Optional: Sort by creation date
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name ?? "Courses"),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: futureCall,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print('Error fetching courses: ${snapshot.error}');
              return const Center(child: Text('Error occurred'));
            }

            var courses = snapshot.data?.docs.map((e) {
                  return Course.fromJson(
                      {'id': e.id, ...e.data() as Map<String, dynamic>});
                }).toList() ??
                [];

            if (courses.isEmpty) {
              return const Center(child: Text('No courses found.'));
            }

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return ListTile(
                  title: Text(course.title ?? "Unknown"),
                  subtitle: Text(
                      'Rating: ${course.rating?.toStringAsFixed(1) ?? 'N/A'}'),
                  leading: course.image != null
                      ? Image.network(course.image!,
                          width: 50, height: 50, fit: BoxFit.cover)
                      : null,
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      // Add course to cart
                      addToCart(course);
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No courses available.'));
        },
      ),
    );
  }

  void addToCart(Course course) {
    // Implement your logic to add the course to the cart
    print('Adding ${course.title} to cart');
  }
}

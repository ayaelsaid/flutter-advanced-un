import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:using_firebase/models/course.dart';
import 'package:using_firebase/pages/course_details.dart';

class CoursesWidget extends StatefulWidget {
  final String rankValue;
  const CoursesWidget({required this.rankValue, super.key});

  @override
  State<CoursesWidget> createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;

  @override
  void initState() {
    futureCall = FirebaseFirestore.instance
        .collection('courses')
        .where('rank', isEqualTo: widget.rankValue)
        .orderBy('created_date', descending: true)
        .get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureCall,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Center(
              child: Text('Error occurred'),
            );
          }

          if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
            return const Center(
              child: Text('No courses found'),
            );
          }

          var courses = List<Course>.from(snapshot.data?.docs
                  .map((e) => Course.fromJson({'id': e.id, ...e.data()}))
                  .toList() ??
              []);

          return GridView.count(
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(courses.length, (index) {
              final course = courses[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CourseDetailsPage.id,
                      arguments: course);
                },
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 100,
                        child: course.image != null
                            ? Image.network(
                                course.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    child: const Icon(Icons.error),
                                  );
                                },
                              )
                            : Container(
                                color: Colors.grey,
                                child: const Icon(Icons.image_not_supported),
                              ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        course.title ?? 'unknown',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            course.rating?.toStringAsFixed(1) ?? 'N/A',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 5),
                          ...List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < (course.rating ?? 0).floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: const Color.fromRGBO(255, 193, 7, 1),
                              size: 20,
                            );
                          }),
                        ],
                      ),
                      //     const SizedBox(height: 5),
                      //     Row(
                      //       children: [
                      //         const Icon(
                      //           Icons.person,
                      //           size: 20,
                      //           color: Colors.grey,
                      //         ),
                      //         const SizedBox(width: 5),
                      //         Expanded(
                      //           child: Text(
                      //             course.instructor?.name ?? 'Unknown',
                      //             style: const TextStyle(fontSize: 14),
                      //             overflow: TextOverflow.ellipsis,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     const SizedBox(height: 5),
                      //     Text(
                      //       '\$${course.price?.toStringAsFixed(2) ?? 'N/A'}',
                      //       style: const TextStyle(fontSize: 14),
                      //     ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}



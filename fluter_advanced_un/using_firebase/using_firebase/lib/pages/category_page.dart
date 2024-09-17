import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:using_firebase/models/category.dart';
import 'package:using_firebase/models/course.dart';
import 'package:using_firebase/utilis/color_utilis.dart';

class AllCategorylist extends StatefulWidget {
  const AllCategorylist({super.key});

  @override
  State<AllCategorylist> createState() => _AllCategorylistState();
}

class _AllCategorylistState extends State<AllCategorylist> {
  String? selectedCategory;

  final Future<QuerySnapshot> futureCall =
      FirebaseFirestore.instance.collection('category').get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: futureCall,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        }

        if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
          return const Center(child: Text('No categories found'));
        }

        var categories = List<Category>.from(
          snapshot.data!.docs.map(
            (e) => Category.fromJson(
                {'id': e.id, ...e.data() as Map<String, dynamic>}),
          ),
        );

        return Scaffold(
          appBar: AppBar(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios_new_sharp),
                Text('Categories',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                Icon(Icons.shopping_cart_sharp),
              ],
            ),
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category.name;
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          Card(
                            color: isSelected
                                ? Colors.white
                                : ColorUtility.grayLight,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: ListTile(
                              title: Text(
                                category.name ?? '',
                                style: TextStyle(
                                  color: isSelected
                                      ? ColorUtility.deepYellow
                                      : Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (selectedCategory == category.name) {
                                      selectedCategory =
                                          null; // Collapse if the same category is selected
                                    } else {
                                      selectedCategory =
                                          category.name; // Expand new category
                                    }
                                  });
                                },
                                icon: Icon(
                                  isSelected
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_right,
                                  color: isSelected
                                      ? ColorUtility.deepYellow
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          // Display courses for the selected category
                          Visibility(
                            visible: selectedCategory == category.name,
                            child: SizedBox(
                              height: 300, // Adjust this height as needed
                              child: CoursesOfCategory(category: category),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CoursesOfCategory extends StatelessWidget {
  final Category category;

  const CoursesOfCategory({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('courses')
          .where('category', isEqualTo: category.name)
          .where('rank', whereIn: [
            'top search',
            'top rated'
          ]) // Correct way to filter by multiple ranks
          .orderBy('created_date', descending: true)
          .get(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return const Center(child: Text('Error occurred'));
        }

        if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
          return const Center(child: Text('No courses found'));
        }

        var courses = snapshot.data!.docs
            .map((doc) => Course.fromJson({'id': doc.id, ...doc.data()}))
            .toList();

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          padding: const EdgeInsets.all(10),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    course.title ?? 'Unknown',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(course.rating?.toStringAsFixed(1) ?? 'N/A',
                          style: const TextStyle(fontSize: 16)),
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
                ],
              ),
            );
          },
        );
      },
    );
  }
}

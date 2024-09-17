import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:using_firebase/models/category.dart';
import 'package:using_firebase/pages/trending_courses.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> selectedCategories = [];

  void _updateSelectedCategory(String category) {
    setState(() {
      if (!selectedCategories.contains(category)) {
        selectedCategories.add(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Search...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Icon(Icons.search),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.shopping_cart),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Trending',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                TrendingCategories(
                  selectedCategories: selectedCategories,
                  onCategorySelected: _updateSelectedCategory,
                ),
                const SizedBox(height: 20),
                FilteredCategories(
                  selectedCategories: selectedCategories,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingCategories extends StatelessWidget {
  final List<String> selectedCategories;
  final void Function(String) onCategorySelected;

  TrendingCategories({
    super.key,
    required this.selectedCategories,
    required this.onCategorySelected,
  });

  final Future<QuerySnapshot> futureCall =
      FirebaseFirestore.instance.collection('category').get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: futureCall,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Error occurred'),
          );
        }

        if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
          return const Center(
            child: Text('No categories found'),
          );
        }

        var categories = List<Category>.from(
          snapshot.data!.docs.map(
            (e) => Category.fromJson(
                {'id': e.id, ...e.data() as Map<String, dynamic>}),
          ),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: categories.map((category) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrendingCoursesPage(
                        category: category,
                      ),
                    ),
                  );
                  onCategorySelected(category.name ?? 'No Name');
                },
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 10,
                    maxWidth: 200,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xffE0E0E0),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    category.name ?? 'No Name',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class FilteredCategories extends StatelessWidget {
  final List<String> selectedCategories;

  FilteredCategories({
    super.key,
    required this.selectedCategories,
  });

  final Future<QuerySnapshot> futureCall =
      FirebaseFirestore.instance.collection('category').get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: futureCall,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Error occurred'),
          );
        }

        if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
          return const Center(
            child: Text('No categories found'),
          );
        }

        var categories = List<Category>.from(
          snapshot.data!.docs.map(
            (e) => Category.fromJson(
                {'id': e.id, ...e.data() as Map<String, dynamic>}),
          ),
        );

        if (selectedCategories.isNotEmpty) {
          categories = categories.where((category) {
            return selectedCategories.contains(category.name);
          }).toList();
        } else {
          categories = [];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedCategories.isNotEmpty) ...[
              const Text(
                'Based on your search',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
            ],
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: selectedCategories.map((categoryName) {
                return Container(
                  constraints: const BoxConstraints(
                    minWidth: 10,
                    maxWidth: 200,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xffE0E0E0),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    categoryName,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

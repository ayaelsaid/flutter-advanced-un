import 'package:flutter/material.dart';

class UserCourse extends StatefulWidget {
  const UserCourse({super.key});

  @override
  State<UserCourse> createState() => _UserCourseState();
}

class _UserCourseState extends State<UserCourse> {
  bool isAllSelected = false;
  bool isDownloadSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.arrow_back_ios_new_sharp),
            Text(
              'Courses',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Icon(Icons.shopping_cart_sharp)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                _buildOptionButton(
                  label: 'All',
                  isSelected: isAllSelected,
                  onPressed: () {
                    setState(() {
                      isAllSelected = true;
                      isDownloadSelected = false;
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildOptionButton(
                  label: 'Download',
                  isSelected: isDownloadSelected,
                  onPressed: () {
                    setState(() {
                      isAllSelected = false;
                      isDownloadSelected = true;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to build option buttons
  Widget _buildOptionButton({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        backgroundColor: isSelected ? Colors.yellow : Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 17,
        ),
      ),
    );
  }
}

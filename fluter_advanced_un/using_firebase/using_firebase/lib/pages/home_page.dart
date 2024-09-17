import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:using_firebase/widgets/categories.dart';
import 'package:using_firebase/widgets/courses.dart';
import 'package:using_firebase/widgets/lable.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Welcome Back! ${FirebaseAuth.instance.currentUser?.displayName}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              LabelWidget(
                name: 'Categories',
                onSeeAllClicked: () {},
              ),
              const CategoriesWidget(),
              const SizedBox(
                height: 20,
              ),
              LabelWidget(
                name: 'Students Also Search For',
                onSeeAllClicked: () {},
              ),
              const SizedBox(height: 20),
              const CoursesWidget(
                rankValue: 'top search',
              ),
              const SizedBox(height: 40),
              LabelWidget(
                name: 'Top Rated Courses',
                onSeeAllClicked: () {},
              ),
              const SizedBox(height: 20),
              const CoursesWidget(
                rankValue: 'top rated',
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('test')
                        .doc('x')
                        .delete();
                  },
                  child: const Text('test'))
            ],
          ),
        ),
      ),
    );
  }
}











// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:using_firebase/pages/login.dart';

// // class HomePage extends StatefulWidget {
// //   static const String id = 'home';
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           const Center(
// //             child: Text('Firebase Auth Status'),
// //           ),
// //           Center(
// //             child: Text(
// //                 '${FirebaseAuth.instance.currentUser?.email},${FirebaseAuth.instance.currentUser?.displayName}'),
// //           ),
// //           StreamBuilder(
// //               stream: FirebaseAuth.instance.authStateChanges(),
// //               builder: (ctx, snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return const Center(
// //                     child: CircularProgressIndicator(),
// //                   );
// //                 }
// //                 if (snapshot.data != null) {
// //                   return const Text('Logged In');
// //                 } else {
// //                   return const Text('Not Logged In');
// //                 }
// //               }),
// //           const SizedBox(height: 10),
// //           ElevatedButton(
// //             onPressed: () {
// //               Navigator.pushNamed(context, LoginPage.id);
// //             },
// //             child: const Text('go'),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CertificatePage extends StatefulWidget {
  const CertificatePage({super.key});

  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  String _courseName = 'C++ For Beginners';
  String _completionDate = 'November 24, 2022';
  String _certificateID = 'SK24568086';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      setState(() {
        _currentUser = user;
        // Fetch additional data as needed (e.g., courseName, completionDate, certificateID)
        // For this example, we use static data, but you would typically fetch this from your database
        _courseName = 'Dynamic Course Name'; // Replace with fetched data
        _completionDate = 'Dynamic Date'; // Replace with fetched data
        _certificateID = 'Dynamic ID'; // Replace with fetched data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.arrow_back_ios_new_sharp),
            Text(
              'Certificate',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use the user data to populate the certificate
            const Text('Certificate of Completion',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 20),
            certificateTexts('This is Certifies That'),
            const SizedBox(height: 10),
            Text(
              _currentUser?.displayName ?? 'User Name',
              style: TextStyle(
                  color: Colors.green[600],
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            const SizedBox(height: 10),
            certificateTexts(
                'Has Successfully Completed the Wallace Training Program, Entitled.'),
            const SizedBox(height: 15),
            Text(_courseName,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 5),
            certificateTexts('Issued on $_completionDate'),
            const SizedBox(height: 10),
            Text('ID: $_certificateID',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 15),
            Text('Calvin E. McGinnis',
                style: TextStyle(
                    color: Colors.green[600],
                    fontWeight: FontWeight.w200,
                    fontSize: 20)),
            const SizedBox(height: 15),
            const Text('Virginia M. Patterson', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            const Text('Virginia M. Patterson', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget certificateTexts(String text) {
    return Text(text, style: TextStyle(fontSize: 16, color: Colors.black54));
  }
}

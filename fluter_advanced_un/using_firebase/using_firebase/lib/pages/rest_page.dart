import 'package:flutter/material.dart';
import 'package:using_firebase/widgets/coutom_text_form.dart';
import 'package:using_firebase/widgets/evaulated_button.dart';

class ResetPasswordPage extends StatefulWidget {
  static const String id = 'resetPassword';
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Reset Password',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 200,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CustomTextFormField(
                hintText: 'Demo@gmail.com',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomElevatedButton(
                onPressed: () {},
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
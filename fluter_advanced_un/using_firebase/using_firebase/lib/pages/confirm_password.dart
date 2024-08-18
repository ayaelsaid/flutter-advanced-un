import 'package:flutter/material.dart';
import 'package:using_firebase/widgets/coutom_text_form.dart';
import 'package:using_firebase/widgets/evaulated_button.dart';

class ConfirmPasswrdPage extends StatefulWidget {
  const ConfirmPasswrdPage({super.key});

  @override
  State<ConfirmPasswrdPage> createState() => _ConfirmPasswrdPageState();
}

class _ConfirmPasswrdPageState extends State<ConfirmPasswrdPage> {
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
            Form(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const CustomTextFormField(
                    hintText: '***********',
                    labelText: 'Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTextFormField(
                    hintText: '***********',
                    labelText: 'Confirm Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'SUBMIT',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
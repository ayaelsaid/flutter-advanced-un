import 'package:flutter/material.dart';
import 'package:using_firebase/pages/forget_password.dart';
import 'package:using_firebase/pages/login.dart';
import 'package:using_firebase/pages/sign_up.dart';
import 'package:using_firebase/utilis/color_utilis.dart';
import 'package:using_firebase/widgets/evaulated_button.dart';
import 'package:using_firebase/widgets/text_button.dart';

class AuthTemplateWidget extends StatefulWidget {
  final Future<void> Function()? onLogin;
  final Future<void> Function()? onSignUp;
  final Widget body;

  AuthTemplateWidget({
    this.onLogin,
    this.onSignUp,
    
    required this.body,
    super.key,
  }) {
    assert(onLogin != null || onSignUp != null,
        'onLogin or onSignUp should not be null');
  }

  @override
  State<AuthTemplateWidget> createState() => _AuthTemplateWidgetState();
}

class _AuthTemplateWidgetState extends State<AuthTemplateWidget> {
  EdgeInsetsGeometry get _padding =>
      const EdgeInsets.symmetric(vertical: 20, horizontal: 20);

  bool get isLogin => widget.onLogin != null;

  String get title => isLogin ? "Login" : "Sign Up";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: _padding
            .subtract(const EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: ColorUtility.grayLight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Or sign with',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: ColorUtility.grayLight,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      horizontal: 0,
                      backgroundColor: const Color(0xff1877f2),
                      foregroundColor: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/facebook.jpg',
                              width: 80,
                              height: 80,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Sign In with Facebook',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 15),
                  CustomElevatedButton(
                    horizontal: 0,
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: Image.asset(
                      'assets/google.png',
                      width: 35,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin
                      ? 'Don\'t have an account?'
                      : 'Already have an account',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                CustomTextButton(
                  label: isLogin ? 'Sign Up' : 'Login',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, isLogin ? SignUpPage.id : LoginPage.id);
                  },
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Text(
            title,
            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: Padding(
              padding: _padding,
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.body,
                      const SizedBox(height: 20),
                      if (isLogin)
                        CustomTextButton(
                          label: 'Forgot Password ?',
                          onPressed: () {
                            Navigator.pushNamed(context, ForgotPasswordPage.id);
                          },
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              horizontal: 0,
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                if (isLogin) {
                                  await widget.onLogin?.call();
                                } else {
                                  await widget.onSignUp?.call();
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      title,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

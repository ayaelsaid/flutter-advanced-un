import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/cubit/auth_cubit.dart';
import 'package:using_firebase/cubit/auth_state.dart';
import 'package:using_firebase/pages/home_page.dart';
import 'package:using_firebase/widgets/auth_template.dart';
import 'package:using_firebase/widgets/coutom_text_form.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, HomePage.id);
        }
      },
      child: AuthTemplateWidget(
        onLogin: () async {
          await context.read<AuthCubit>().login(
                email: emailController.text,
                password: passwordController.text,
              );
        },
        body: Column(
          children: [
            CustomTextFormField(
              controller: emailController,
              hintText: 'aya@gmail.com',
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: passwordController,
              hintText: '***********',
              labelText: 'Password',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

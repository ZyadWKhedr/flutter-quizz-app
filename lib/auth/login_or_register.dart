import 'package:flutter/material.dart';
import 'package:quiz_app_working/pages/login_page.dart';
import 'package:quiz_app_working/pages/signup_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        onTap: togglePages,
      );
    } else {
      return SignupPage(
        onTap: togglePages,
      );
    }
  }
}


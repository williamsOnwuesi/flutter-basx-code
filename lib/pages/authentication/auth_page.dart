import 'package:flutter/material.dart';
import 'package:gt_bank_app/pages/authentication/login.dart';
import 'package:gt_bank_app/pages/authentication/sign_up.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginWidget(
        signUpOnClick: toggle,
      );
    } else {
      return SignUpWidget(
        signInOnClick: toggle,
      );
    }
  }

  void toggle() => setState(() => isLogin = !isLogin);
}

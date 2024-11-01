// import 'dart:js_interop';

import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gt_bank_app/pages/welcome_page.dart';
// import 'package:gt_bank_app/services/utils.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => EmailVerificationPageState();
}

class EmailVerificationPageState extends State<EmailVerificationPage> {
  bool emailIsVerified = false;
  bool canSendVerificationEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    emailIsVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!emailIsVerified) {
      sendVerificationEmail();
    }

    timer = Timer.periodic(
        const Duration(seconds: 7), (_) => checkIfEmailIsVerified());
  }

  Future checkIfEmailIsVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      emailIsVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (emailIsVerified) timer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;

      await user.sendEmailVerification();

      // await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      setState(() {
        canSendVerificationEmail = false;
      });

      await Future.delayed(const Duration(seconds: 10));

      setState(() {
        canSendVerificationEmail = true;
      });
      //
    } catch (e) {
      // Utils().showSnackBar(e.toString());

      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
            title: 'Oh Snap!',
            message: e.toString(),
            contentType: ContentType.failure),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => emailIsVerified
      ? const WelcomePage(title: 'Welcome User')
      : Scaffold(
          appBar: AppBar(
            title: const Text('Email Verification Section'),
          ),
          body: Column(
            children: [
              ElevatedButton(
                  onPressed:
                      canSendVerificationEmail ? sendVerificationEmail : null,
                  child: const Text('Resend Verification Email')),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Cancel')),
            ],
          ));
}

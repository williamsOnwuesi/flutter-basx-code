import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gt_bank_app/main.dart';
import 'package:gt_bank_app/pages/authentication/password_reset_page.dart';
// import 'package:gt_bank_app/services/utils.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback signUpOnClick;

  const LoginWidget({Key? key, required this.signUpOnClick}) : super(key: key);

  @override
  State<LoginWidget> createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future loginWithFirebase() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    var email = emailController.text;
    var password = passwordController.text;

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //
    } on FirebaseAuthException catch (e) {
      // Utils().showSnackBar(e.message);

      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
            title: 'Oh Snap!',
            message: '${e.message}',
            contentType: ContentType.failure),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Column(children: [
        TextFormField(
          controller: emailController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Email'),
          obscureText: false,
        ),
        const SizedBox(
          height: 25,
        ),
        TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        ElevatedButton(
            onPressed: () {
              loginWithFirebase();
            },
            child: const Text("Login")),
        GestureDetector(
          child: Text(
            'Forgot Password',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 25,
            ),
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PasswordResetPage())),
        ),
        RichText(
            text: TextSpan(
                style: const TextStyle(
                    color: Color.fromARGB(255, 73, 190, 245), fontSize: 20),
                text: 'No account?   ',
                children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.signUpOnClick,
                  text: 'Sign Up',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary))
            ])),
      ]),
    );
  }
}

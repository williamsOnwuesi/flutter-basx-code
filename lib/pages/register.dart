import 'package:flutter/material.dart';
import 'package:gt_bank_app/services/database_manager.dart';
import 'package:ulid/ulid.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  final emailController = TextEditingController();

  void createNewUser() async {
    var randomId = Ulid().toUuid();

    Map<String, dynamic> registrationData = {
      "name": nameController.text,
      'email': emailController.text,
      "id": randomId,
    };

    await DatabaseClient()
        .createNewCustomer(registrationData, randomId)
        .then((res) => {debugPrint(res)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const Text('Name'),
      TextField(
        controller: nameController,
      ),
      const Text('Email'),
      TextField(
        controller: emailController,
      ),
      ElevatedButton.icon(
          onPressed: createNewUser, label: const Text('Book Reservation'))
    ])));
  }
}

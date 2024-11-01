import 'package:flutter/material.dart';
import 'package:gt_bank_app/services/database_manager.dart';

class UpdateCustomer extends StatefulWidget {
  const UpdateCustomer({super.key});

  @override
  State<UpdateCustomer> createState() => UpdateCustomerState();
}

class UpdateCustomerState extends State<UpdateCustomer> {
  //
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController emailUpdateController = TextEditingController();
  String id = "selectedUserId";

  void updateCustomerData() async {
    var updateData = {
      "name": nameUpdateController,
      "email": emailUpdateController,
      "id": id
    };

    await DatabaseClient().updateCustumerData(updateData, id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              const Text("Name"),
              TextField(
                controller: nameUpdateController,
              )
            ],
          ),
          Column(
            children: [
              const Text("Email"),
              TextField(
                controller: emailUpdateController,
              )
            ],
          ),
          ElevatedButton(
              onPressed: updateCustomerData,
              child: const Text("Update Your Data"))
        ],
      ),
    );
  }
}

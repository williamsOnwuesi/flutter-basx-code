import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:gt_bank_app/services/database_manager.dart';

class CurrentCustomers extends StatefulWidget {
  const CurrentCustomers({super.key});

  @override
  State<CurrentCustomers> createState() => __CurrentCustomersState();
}

class __CurrentCustomersState extends State<CurrentCustomers> {
  Stream? customersDataStream;

  TextEditingController nameController = TextEditingController();
  var emailController = TextEditingController();

  void getCustomersOnLoad() async {
    customersDataStream = await DatabaseClient().readCustomerData();
    setState(() {});
  }

  Future showUpdatePopUp(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: Column(children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Name"),
                    TextField(
                      controller: nameController,
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text("Email"),
                    TextField(
                      controller: emailController,
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      updateCustomerData(id);
                    },
                    child: const Text("Update Data"))
              ]),
            ),
          ));

  Future updateCustomerData(String id) async {
    //
    //start
    Map<String, dynamic> custumerUpdateData = {
      "name": nameController.text,
      'email': emailController.text,
      "id": id,
    };

    await DatabaseClient()
        .updateCustumerData(custumerUpdateData, id)
        .then((value) {
      Navigator.pop(context);
    });
  }

  Future<void> deleteUser(String id) async {
    await DatabaseClient().deleteUserData(id);
  }

  @override
  void initState() {
    getCustomersOnLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Customer Data"),
      ),
      body: Container(
          child: StreamBuilder(
              stream: customersDataStream,
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot sD = snapshot.data.docs[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(sD["name"]),
                                      Text(sD["email"]),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            nameController.text = sD["name"];
                                            emailController.text = sD["email"];
                                            showUpdatePopUp(sD["id"]);
                                          },
                                          child: const Text("Update Data")),
                                      ElevatedButton(
                                          onPressed: () {
                                            deleteUser(sD["id"]);
                                          },
                                          child: const Text("Delete Data")),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          );
                        })
                    : Container();
              })),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseClient {
  //Create New Customer data in Firebase
  Future createNewCustomer(
      Map<String, dynamic> userRegistrationData, String id) async {
    return await FirebaseFirestore.instance
        .collection("Customers")
        .doc(id)
        .set(userRegistrationData);
  }

  //Read Current Customer data from Firebase
  Future<Stream<QuerySnapshot>> readCustomerData() async {
    return await FirebaseFirestore.instance.collection("Customers").snapshots();
  }

  //Read Current Customer data from Firebase
  Future updateCustumerData(
      Map<String, dynamic> userUpdateData, String id) async {
    return await FirebaseFirestore.instance
        .collection("Customers")
        .doc(id)
        .set(userUpdateData);
  }

  //Read Current Customer data from Firebase
  Future deleteUserData(String id) async {
    return await FirebaseFirestore.instance
        .collection("Customers")
        .doc(id)
        .delete();
  }
}

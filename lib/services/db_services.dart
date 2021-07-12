import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final CollectionReference orders =
    FirebaseFirestore.instance.collection('orders');

class DatabaseServices {
  // Order services

  static Future<void> addOrder(Map<String, dynamic> object) {
    return orders
        .add(object)
        .then((_) => print("Order added successfully.."))
        .catchError((error) => print("Failed to add order $error"));
  }

  static Stream<QuerySnapshot> orderStream() {
    return orders.where('userID', isEqualTo: _auth.currentUser.uid).snapshots();
  }
}

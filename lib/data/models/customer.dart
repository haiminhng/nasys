import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
class Customer extends User {
  String name;
  String phoneNumber;
  String? email;
  String? address;
  int rewardPoints;
  String? branchId;

  Customer({
    required String uid,
    required this.name,
    required this.phoneNumber,
    this.email,
    this.address,
    this.rewardPoints = 0,
    this.branchId,
  }) : super(uid: uid, email: email);

  Customer.fromFirestore(DocumentSnapshot doc)
      : name = doc.data()?['name'] ?? '',
        phoneNumber = doc.data()?['phoneNumber'] ?? '',
        email = doc.data()?['email'],
        address = doc.data()?['address'],
        rewardPoints = doc.data()?['rewardPoints'] ?? 0,
        branchId = doc.data()?['branchId'],
        super(uid: doc.id, email: doc.data()?['email']);

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'rewardPoints': rewardPoints,
      'branchId': branchId,
    };
  }
}
*/

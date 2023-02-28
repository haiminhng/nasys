import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';
/*
class Staff extends User {
  String name;
  String position;
  String email;
  String phoneNumber;

  Staff({
    required String uid,
    required this.name,
    required this.position,
    required this.email,
    required this.phoneNumber,
  }) : super(uid: uid, email: email);

  Staff.fromFirestore(DocumentSnapshot doc)
      : name = doc.data()?['name'] ?? '',
        position = doc.data()?['position'] ?? '',
        email = doc.data()?['email'] ?? '',
        phoneNumber = doc.data()?['phoneNumber'] ?? '',
        super(uid: doc.id, email: doc.data()?['email']);

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'position': position,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
 */
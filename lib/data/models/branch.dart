import 'package:cloud_firestore/cloud_firestore.dart';

class Branch {
  String id;
  String name;
  String address;
  String? policy;
  String? phone;
  String? email;
  List<dynamic>? staffIds;
  List<dynamic>? couponIds;

  Branch({
    required this.id,
    required this.name,
    required this.address,
    this.policy,
    this.phone,
    this.email,
    this.staffIds,
    this.couponIds,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'address': address,
      'policy': policy,
      'phone': phone,
      'email': email,
      'staffIds': staffIds,
      'couponIds': couponIds,
    };
  }

  factory Branch.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Branch(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      policy: data['policy'],
      phone: data['phone'],
      email: data['email'],
      staffIds: data['staffIds'],
      couponIds: data['couponIds'],
    );
  }
}

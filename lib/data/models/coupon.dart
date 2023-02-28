import 'package:cloud_firestore/cloud_firestore.dart';

class Coupon {
  String id;
  String name;
  String description;
  Timestamp expiryDate;
  int rewardPointsRequired;
  bool redeemed;
  String branchId;

  Coupon({
    required this.id,
    required this.name,
    required this.description,
    required this.expiryDate,
    required this.rewardPointsRequired,
    required this.redeemed,
    required this.branchId,
  });

  Coupon.fromFirestore(DocumentSnapshot snapshot)
      : id = snapshot.id,
        name = snapshot.get('name'),
        description = snapshot.get('description'),
        expiryDate = snapshot.get('expiry_date'),
        rewardPointsRequired = snapshot.get('reward_points_required'),
        redeemed = snapshot.get('redeemed'),
        branchId = snapshot.get('branch_id');

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'expiry_date': expiryDate,
      'reward_points_required': rewardPointsRequired,
      'redeemed': redeemed,
      'branch_id': branchId,
    };
  }
}

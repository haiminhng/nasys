import 'package:cloud_firestore/cloud_firestore.dart';

class CheckIn {
  final Timestamp checkInTime;
  final String policy;
  final int rewardPointsEarned;
  final bool emailSent;
  final bool couponSent;

  CheckIn({
    required this.checkInTime,
    required this.policy,
    required this.rewardPointsEarned,
    required this.emailSent,
    required this.couponSent,
  });

  factory CheckIn.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CheckIn(
      checkInTime: data['check_in_time'],
      policy: data['policy'],
      rewardPointsEarned: data['reward_points_earned'],
      emailSent: data['email_sent'],
      couponSent: data['coupon_sent'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'check_in_time': checkInTime,
      'policy': policy,
      'reward_points_earned': rewardPointsEarned,
      'email_sent': emailSent,
      'coupon_sent': couponSent,
    };
  }
}

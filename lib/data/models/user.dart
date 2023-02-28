import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;

  User({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
  });

  factory User.fromFirebaseUser(User firebaseUser) {
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      displayName: firebaseUser.displayName,
      photoURL: firebaseUser.photoURL,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}

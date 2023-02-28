/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nasys/screens/login/login_screen.dart';
import 'package:nasys/theme/theme.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _register() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate back to login screen after successful registration
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message ?? 'An error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.getTextColor(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: textColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 300,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: textColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nasys/data/models/user.dart' as app;
import 'package:nasys/screens/login/login_screen.dart';
import 'package:nasys/theme/theme.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _register() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user in Firestore
      final firebaseUser = userCredential.user!;
      final user = app.User(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toFirestore());

      // Navigate back to login screen after successful registration
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message ?? 'An error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.getTextColor(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: textColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 300,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: textColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

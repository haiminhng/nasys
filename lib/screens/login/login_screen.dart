import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nasys/screens/login/forgot_password_screen.dart';
import 'package:nasys/screens/login/registration_screen.dart';
import 'package:nasys/screens/home_screen.dart';
import 'package:nasys/theme/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  void _login() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to home screen after successful login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen(title: "Nasys")),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message ?? 'An error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.getTextColor(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFDDA0DD)),
                  ),
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
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFDDA0DD)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Log in'),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                );
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: textColor),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
              child: Text(
                'Don\'t have an account? Register here',
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

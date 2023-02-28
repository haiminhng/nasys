import 'package:flutter/material.dart';
import 'package:nasys/theme/theme.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.getTextColor(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: textColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Send password reset email
              },
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}

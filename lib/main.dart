import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'package:nasys/screens/welcome_screen.dart';
import 'package:nasys/screens/welcome_screen_web.dart';
import 'package:nasys/screens/login/login_screen.dart';
import 'package:nasys/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MyApp(isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp(this.isFirstTime, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nails Checkin System',
      theme: AppTheme.lightTheme,
      home: isFirstTime ? (kIsWeb ? const WelcomeScreenWeb() : const WelcomeScreen()) : const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

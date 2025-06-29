import 'package:flutter/material.dart';
import 'package:hello_flutter_web/screens/dashboard_page.dart';
import 'package:hello_flutter_web/screens/login_page.dart';
import 'package:hello_flutter_web/screens/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GMGN.AI Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}

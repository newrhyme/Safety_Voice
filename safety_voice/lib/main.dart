// lib/main.dart
import 'package:flutter/material.dart';
import 'package:safety_voice/pages/setup_screen.dart';
import 'package:safety_voice/pages/signup_screen.dart';
import 'pages/main_screen.dart';
import 'pages/login_screen.dart';
import 'pages/timetable_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '안전한 목소리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Noto Sans KR',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/login': (context) => const LoginScreen(),
        '/timetable': (context) => const TimeTableDemo(),
        '/signup': (context) => const SignupScreen(),
        '/setup': (context) => const SetupScreen(),
        
      },
    );
  }
}


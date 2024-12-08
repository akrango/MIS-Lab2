import 'package:flutter/material.dart';
import 'package:jokes_app_lab2/screens/home.dart';
import 'package:jokes_app_lab2/screens/jokes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/type': (context) => const Jokes(),
        '/random_joke': (context) => const Jokes(),
      },
    );
  }
}



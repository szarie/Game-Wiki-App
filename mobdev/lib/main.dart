import 'package:flutter/material.dart';
import 'package:mobdev/home.dart';
import 'package:mobdev/agent_list.dart';
import 'package:mobdev/profile.dart';
import 'package:mobdev/fav.dart';
// Import other pages

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/agent_list': (context) => AgentListPage(),
        '/favorites': (context) => FavoritePage(), // Create this page
        '/profile': (context) => ProfilePage(), // Create this page
      },
    );
  }
}

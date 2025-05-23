import 'package:flutter/material.dart';
import 'package:mobdev/agent_details.dart';
import 'package:mobdev/home.dart';
import 'package:mobdev/agent_list.dart';
import 'package:mobdev/profile.dart';
import 'package:mobdev/fav.dart';
import 'package:mobdev/agent.dart';
import 'package:mobdev/login.dart';
import 'package:mobdev/questionscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zenless Zone Zero Wiki App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: Colors.yellowAccent,
          secondary: Color(0xFF47FF56),
        ),
        fontFamily: 'RobotoMono',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/agent_list': (context) => AgentListPage(),
        '/favorites': (context) => FavoritePage(),
        '/profile': (context) => ProfilePage(),
        '/quiz': (context) => QuizScreen(),
        '/agent_details': (context) => AgentDetailsPage(
              agent: ModalRoute.of(context)!.settings.arguments as Agent,
            ),
      },
    );
  }
}

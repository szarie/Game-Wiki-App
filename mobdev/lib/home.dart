import 'package:flutter/material.dart';
import 'package:mobdev/nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Home Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/icons/fubuki.jpg',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Icon(Icons.calculate_outlined,
                      size: 50, color: const Color.fromARGB(255, 0, 0, 0)),
                  Text(
                    'Calculator',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

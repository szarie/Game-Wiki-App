import 'package:flutter/material.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 27, 26, 26),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0500),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.home_outlined),
                  color: _currentIndex == 0
                      ? const Color.fromARGB(255, 71, 255, 86)
                      : const Color.fromARGB(255, 255, 255, 255),
                  iconSize: 30.0,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.people_alt_outlined),
                  color: _currentIndex == 0
                      ? const Color.fromARGB(255, 71, 255, 86)
                      : const Color.fromARGB(255, 255, 255, 255),
                  iconSize: 30.0,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border_outlined),
                  color: _currentIndex == 0
                      ? const Color.fromARGB(255, 71, 255, 86)
                      : const Color.fromARGB(255, 255, 255, 255),
                  iconSize: 30.0,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.person_outline),
                  color: _currentIndex == 0
                      ? const Color.fromARGB(255, 71, 255, 86)
                      : const Color.fromARGB(255, 255, 255, 255),
                  iconSize: 30.0,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
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

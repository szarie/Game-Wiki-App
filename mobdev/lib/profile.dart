import 'package:flutter/material.dart';
import 'package:mobdev/nav.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile Page', // Fixed the page title
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Rest of your content
          ],
        ),
      ),
    );
  }
}

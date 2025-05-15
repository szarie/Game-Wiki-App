import 'package:flutter/material.dart';
import 'package:mobdev/nav.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Favorite Page', // Fixed the page title
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Rest of your content
          ],
        ),
      ),
    );
  }
}

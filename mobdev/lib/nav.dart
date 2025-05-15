import 'package:flutter/material.dart';
// Import other page files

class BasePage extends StatefulWidget {
  final int currentIndex;
  final Widget child;
  final String? title;

  const BasePage({
    Key? key,
    required this.currentIndex,
    required this.child,
    this.title,
  }) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late int _currentIndex;

  String _getTitle() {
    if (widget.title != null) return widget.title!;

    switch (_currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Agents List';
      case 2:
        return 'Favorites';
      case 3:
        return 'Profile';
      default:
        return 'App';
    }
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      appBar: AppBar(
        title: Text(_getTitle(),
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 156, 255, 100), // Change icon color
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 27, 26, 26),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width *
                  0.0500, // padding for the bottom bar
            ),
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
                  onPressed: () {
                    if (_currentIndex != 0) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/', // Home page route
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.people_alt_outlined),
                  color: _currentIndex == 1
                      ? const Color.fromARGB(255, 71, 255, 86)
                      : const Color.fromARGB(255, 255, 255, 255),
                  iconSize: 30.0,
                  onPressed: () {
                    if (_currentIndex != 1) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/agent_list', // Agent list route
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border_outlined),
                  color: _currentIndex == 2
                      ? const Color.fromARGB(255, 71, 255, 86)
                      : const Color.fromARGB(255, 255, 255, 255),
                  iconSize: 30.0,
                  onPressed: () {
                    if (_currentIndex != 2) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/favorites', // Favorites route
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person_outline),
                  color: _currentIndex == 3
                      ? const Color.fromARGB(255, 71, 255, 86)
                      : const Color.fromARGB(255, 255, 255, 255),
                  iconSize: 30.0,
                  onPressed: () {
                    if (_currentIndex != 3) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/profile', // Profile route
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

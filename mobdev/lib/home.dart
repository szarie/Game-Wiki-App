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
  // List<dynamic> _items = [];

  // @override
  // void initState() {
  //   super.initState();
  //   readJson();
  // }

  // // Future<void> readJson() async {
  // //   final String response =
  // //       await rootBundle.loadString('assets/json/example.json');
  // //   final data = await json.decode(response);
  // //   setState(() {
  // //     _items = data["items"];
  // //   });
  // // }
  // Future<void> readJson() async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       setState(() {
  //         _items = data;
  //       });
  //     } else {
  //       print('Failed to load albums: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //    // print('Error fetching albums: $e');

  //     setState(() {
  //       _items = [];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //         icon: Icon(Icons.settings),
      //         color: const Color.fromARGB(255, 255, 255, 255),
      //         onPressed: () {}),
      //   ],
      //   centerTitle: true,
      //   title: const Text('HOME',
      //       style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
      //   backgroundColor: const Color.fromARGB(255, 71, 96, 255),
      //   titleTextStyle: TextStyle(
      //       color: const Color.fromARGB(255, 8, 6, 6),
      //       fontSize: 25.00,
      //       fontWeight: FontWeight.bold),
      // ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 189, 221, 248),
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
                  color: const Color.fromARGB(255, 0, 0, 0),
                  iconSize: 30.0,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.people_alt_outlined),
                  color: const Color.fromARGB(255, 0, 0, 0),
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
                  color: const Color.fromARGB(255, 0, 0, 0),
                  iconSize: 30.0,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.person_outline),
                  color: const Color.fromARGB(255, 0, 0, 0),
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

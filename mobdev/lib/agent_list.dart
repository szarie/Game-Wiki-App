import 'package:flutter/material.dart';
import 'package:mobdev/nav.dart';

class AgentListPage extends StatefulWidget {
  const AgentListPage({super.key});
  @override
  State<AgentListPage> createState() => _AgentListPageState();
}

class _AgentListPageState extends State<AgentListPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 1,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Agent List Page', // Fixed the page title
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Rest of your content
          ],
        ),
      ),
    );
  }
}

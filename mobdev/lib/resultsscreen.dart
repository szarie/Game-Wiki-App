import 'package:flutter/material.dart';
import 'package:mobdev/questionscreen.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultsScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String feedback;
    if (score == totalQuestions) {
      feedback = 'Perfectly Done!';
    } else if (score >= totalQuestions / 2) {
      feedback = 'Great job, Agent!';
    } else {
      feedback = 'Better luck next run!';
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 156, 255, 100)), // Change icon color
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/profile');
          },
        ),
        title: const Text('Results'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Card(
          color: Colors.grey[850],
          margin: const EdgeInsets.all(24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.emoji_events, color: Colors.yellowAccent, size: 80),
                const SizedBox(height: 20),
                Text(
                  'Your Score',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  '$score / $totalQuestions',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  feedback,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => QuizScreen()),
                      (route) => false,
                    );
                  },
                  icon: Icon(Icons.restart_alt, color: Colors.black),
                  label: Text('Retry Quiz',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellowAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/profile');
                  },
                  icon: Icon(Icons.person_outlined, color: Colors.black),
                  label: Text('Back to Profile',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 156, 255, 100),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

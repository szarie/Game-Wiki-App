import 'package:flutter/material.dart';
import 'package:mobdev/questions.dart';
import 'package:mobdev/resultsscreen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;
  bool answered = false;

  void _answerQuestion(int selectedIndex) {
    if (answered) return;

    final correctIndex = questions[currentQuestionIndex].correctAnwserIndex;

    setState(() {
      selectedAnswerIndex = selectedIndex;
      answered = true;

      if (selectedIndex == correctIndex) {
        score++;
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
          selectedAnswerIndex = null;
          answered = false;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ResultsScreen(
                score: score,
                totalQuestions: questions.length,
              ),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final correctIndex = question.correctAnwserIndex;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 156, 255, 100)), // Change icon color
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/profile');
          },
        ),
        title: Text('Zenless Zone Zero Quiz'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          color: Colors.grey[850],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Question ${currentQuestionIndex + 1}/${questions.length}',
                  style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  question.question,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 30),
                ...List.generate(question.options.length, (index) {
                  Color? buttonColor;
                  if (answered) {
                    if (index == correctIndex) {
                      buttonColor = Colors.greenAccent;
                    } else if (index == selectedAnswerIndex) {
                      buttonColor = Colors.redAccent;
                    } else {
                      buttonColor = Colors.grey[700];
                    }
                  } else {
                    buttonColor = Colors.yellowAccent;
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _answerQuestion(index),
                      child: Text(
                        question.options[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: answered && index != correctIndex
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

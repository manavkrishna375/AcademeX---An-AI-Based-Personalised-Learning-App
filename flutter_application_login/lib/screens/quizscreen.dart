import 'dart:math';

import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> questionBank = [
   {
    "question": "What will the output of the following Python code snippet be?\nprint(2**3**2)",
    "options": ["64", "512", "729", "256"],
    "correct_answer": "729"
},
{
    "question": "Which of the following is used to define a block of code in Python language?",
    "options": ["Brackets {}", "Keywords", "Indentation", "Quotes \"\""],
    "correct_answer": "Indentation"
},
{
    "question": "What does the following Python code return?\nnot(3 > 4) not (1 == 1)",
    "options": ["SyntaxError", "True", "False", "None"],
    "correct_answer": "SyntaxError"
},
{
    "question": "What is the output of the following code snippet?\nlist = ['a', 'b', 'c', 'd', 'e']\nprint(list[10:])",
    "options": ["['e']", "Error", "[]", "['a', 'b', 'c', 'd', 'e']"],
    "correct_answer": "[]"
},
{
    "question": "Which of the following is the correct way to create a dictionary in Python?",
    "options": ["dict = {\"name\": \"John\", 123: \"doe\"}", "dict = [\"name\": \"John\", \"age\": 25]", "dict = {\"name\": \"John\", \"age\": 25}", "dict = (name=\"John\", age=25)"],
    "correct_answer": "dict = {\"name\": \"John\", \"age\": 25}"
},
{
    "question": "What will the following code output?\ndef foo(k):\n    k = [1]\n\nq = [0]\nfoo(q)\nprint(q)",
    "options": ["[0]", "[1]", "None", "Error"],
    "correct_answer": "[0]"
},
{
    "question": "What is the output of the following code?\nx = \"abcdef\"\ni = \"a\"\nwhile i in x[:-1]:\n    x = x[:-1]\n    print(i, end = \" \")",
    "options": ["a a a a a", "a", "Infinite loop", "No output"],
    "correct_answer": "a a a a a"
},
{
    "question": "How do you insert an item at a given position within a list in Python?",
    "options": ["list.append(index, item)", "list.insert(index, item)", "list.add(index, item)", "list.put(index, item)"],
    "correct_answer": "list.insert(index, item)"
},
{
    "question": "What is the output of the following code snippet?\nx = lambda a, b, c : a + b + c\nprint(x(5, 10, 20))",
    "options": ["15", "35", "30", "SyntaxError"],
    "correct_answer": "35"
},
{
    "question": "How does Python manage memory?",
    "options": ["Garbage Collection", "Reference Counting", "Both a and b", "Manual Management"],
    "correct_answer": "Both a and b"
}

    // Add more questions here
  ];

  Map<int, String> _selectedAnswers = {};

  int score = 0;

  @override
  void initState() {
    super.initState();
    _shuffleQuestions();
  }

  void _shuffleQuestions() {
    setState(() {
      questionBank.shuffle(Random());
    });
  }

  void _checkAnswers() {
  int localScore = 0;
  for (int i = 0; i < questionBank.length; i++) {
    if (_selectedAnswers[i] == questionBank[i]["correct_answer"]) {
      localScore++;
    }
  }

  setState(() {
    score = localScore;
  });

  // Show score dialog
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Quiz Completed!"),
      content: Text("You scored $score out of ${questionBank.length}"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.popAndPushNamed(context, '/home'); // Navigate to HomePage with histogram
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Python Quiz"),
      ),
      body: ListView.builder(
        itemCount: questionBank.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}. ${questionBank[index]['question']}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: _selectedAnswers[index],
                    hint: Text("Select Answer"),
                    isExpanded: true,
                    items: questionBank[index]["options"].map<DropdownMenuItem<String>>((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedAnswers[index] = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkAnswers,
        child: Icon(Icons.check),
      ),
    );
  }
}
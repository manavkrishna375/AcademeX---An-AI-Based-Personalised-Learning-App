import 'package:flutter/material.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Performance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SelectionPage(),
        '/quiz/python': (context) => QuizScreen(),
        '/quiz/java': (context) => JavaQuizScreen(),
        '/quiz/html': (context) => HtmlQuizScreen(),
        '/quiz/c': (context) => CQuizScreen(),
        '/quiz/cpp': (context) => CppQuizScreen(),
        '/home': (context) => HomePage(),
      },
    );
  }
}

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection Page'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: _selectedCourse,
                hint: Text("Select Course"),
                items: ['Python', 'Java', 'HTML','C','C++'].map((String course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (newValue) => setState(() => _selectedCourse = newValue),
                validator: (value) => value == null ? 'Please select a course' : null,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Check if the selected course is Python before navigating
                    if (_selectedCourse == "Python") {
                      Navigator.pushNamed(context, '/quiz/python');
                    } else if (_selectedCourse == "Java") {
                      Navigator.pushNamed(context, '/quiz/java');
                    } else if (_selectedCourse == "HTML") {
                      Navigator.pushNamed(context, '/quiz/html');
                    }else if (_selectedCourse == "C") {
                      Navigator.pushNamed(context, '/quiz/c');
                    }else if (_selectedCourse == "C++") {
                      Navigator.pushNamed(context, '/quiz/cpp');
                    }else {
                      // Handle cases where another course is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select a valid option")),
                      );
                    }
                  }
                },
                child: Text('Go to Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
    void navigateToNotes(BuildContext context, String topic) {
    if (topic == "Java") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotesPage()),
      );
    } else {
       // Optionally, display a message for other topics or perform no action.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No notes available for $topic")),
      );
    }
  }
}



class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
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
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Performance'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show PerformanceHistogram directly
          PerformanceHistogram(),
          SizedBox(height: 20), // Add spacing between histogram and icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.note),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotesMenuPage()),
                      );
                    },
                  ),
                  Text('Notes'),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.school),
                    onPressed: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesMenuPage2()),
                );
                    },
                  ),
                  Text('Lectures'),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.book),
                    onPressed: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectionPage()),
                );
                    },
                  ),
                  Text('Other Courses'),
                ],
              ),
            ],
          ),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
class NotesMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Notes"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Java"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage())); // Assuming NotesPage is for Java
            },
          ),
          ListTile(
            title: Text("Python"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PythonNotesPage())); // PythonNotesPage to be defined similarly to NotesPage
            },
          ),
          ListTile(
            title: Text("HTML"),
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => HTMLNotesPage()));
            },
          ),
          ListTile(
            title: Text("C"),
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => CNotesPage()));
            },
          ),
          ListTile(
            title: Text("C++"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CppNotesPage()));
            },
          ),
        ],
      ),
    );
  }
}
class NotesMenuPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Lectures"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Java"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LecturesPage())); // Assuming NotesPage is for Java
            },
          ),
          ListTile(
            title: Text("Python"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LecturesPage2())); // PythonNotesPage to be defined similarly to NotesPage
            },
          ),
          ListTile(
            title: Text("HTML"),
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => LecturesPage3())); 
            },
          ),
          ListTile(
            title: Text("C"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LecturesPage4())); 
              
            },
          ),
          ListTile(
            title: Text("C++"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LecturesPage5())); 
              
            },
          ),
        ],
      ),
    );
  }
}
class NotesPage extends StatelessWidget {
  final List<String> javaTopics = [
    "Java  Fundamentals",
    "Object-Oriented Programming (OOP)",
    "Core Java APIs",
    "Exception Handling and File I/O",
    "Java Collections and Data Structures",
    "Concurrency and Multithreading",
    "JavaFX and GUI Development",
    "Networking and Database Integration",
    "Web Development with Java",
    "Advanced Java and Enterprise Features"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Java Materials'),
      ),
      body: ListView.builder(
        itemCount: javaTopics.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(javaTopics[index]),
              onTap: () async {
                var url = 'https://www.google.com/search?q=${Uri.encodeComponent(javaTopics[index])}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Could not launch $url'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
class PythonNotesPage extends StatelessWidget {
  final List<String> pythonTopics = [
    "Python Basics",
    "Object-Oriented Programming in Python",
    "Python Libraries and Modules",
    "Error Handling in Python",
    "Python Data Structures and Algorithms",
    "Concurrency and Parallelism in Python",
    "GUI Programming with Tkinter",
    "Networking and Databases in Python",
    "Web Development with Django and Flask",
    "Advanced Python Topics and Performance"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Python Materials'),
      ),
      body: ListView.builder(
        itemCount: pythonTopics.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(pythonTopics[index]),
              onTap: () async {
                var url = 'https://www.google.com/search?q=${Uri.encodeComponent(pythonTopics[index])}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Could not launch $url'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
class HTMLNotesPage extends StatelessWidget {
  final List<String> htmlTopics = [
    "HTML Basics",
    "HTML Elements and Attributes",
    "HTML Forms",
    "HTML5 Semantic Elements",
    "HTML Tables",
    "HTML5 Multimedia",
    "HTML5 Canvas and SVG",
    "CSS Basics",
    "CSS Box Model",
    "CSS Flexbox and Grid Layout"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTML Materials'),
      ),
      body: ListView.builder(
        itemCount: htmlTopics.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(htmlTopics[index]),
              onTap: () async {
                var url = 'https://www.google.com/search?q=${Uri.encodeComponent(htmlTopics[index])}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Could not launch $url'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}


class CNotesPage extends StatelessWidget {
  final List<String> cTopics = [
    "C Fundamentals",
    "Variables and Data Types",
    "Control Structures",
    "Functions",
    "Arrays and Pointers",
    "File Handling",
    "Dynamic Memory Allocation",
    "Structures and Unions",
    "Preprocessor Directives",
    "Advanced C Concepts"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C Materials'),
      ),
      body: ListView.builder(
        itemCount: cTopics.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(cTopics[index]),
              onTap: () async {
                var url = 'https://www.google.com/search?q=${Uri.encodeComponent(cTopics[index])}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Could not launch $url'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
class CppNotesPage extends StatelessWidget {
  final List<String> cppTopics = [
    "C++ Basics",
    "Object-Oriented Programming (OOP) in C++",
    "Standard Template Library (STL)",
    "File Handling in C++",
    "Data Structures in C++",
    "Multithreading and Concurrency in C++",
    "GUI Development with Qt",
    "Networking in C++",
    "Game Development with C++",
    "Advanced C++ Features"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C++ Materials'),
      ),
      body: ListView.builder(
        itemCount: cppTopics.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(cppTopics[index]),
              onTap: () async {
                var url = 'https://www.google.com/search?q=${Uri.encodeComponent(cppTopics[index])}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Could not launch $url'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}




class LecturesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lectures = [
     {"title": "Java Full Course", "url": "https://youtube.com/playlist?list=PLBlnK6fEyqRjKA_NuK9mHmlk0dZzuP1P5&si=MdNpYsP8uiABAEzW"},
   
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Videos'),
      ),
      body: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lectures[index]["title"]!),
            onTap: () async {
              final url = lectures[index]["url"]!;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not launch $url'),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
class LecturesPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lectures = [
     {"title": "Python Full Course", "url": "https://youtube.com/playlist?list=PLBlnK6fEyqRiueC_HzwFallNO76hfXBB7&si=MsWtleO_xoUbMewU"},
   
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Videos'),
      ),
      body: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lectures[index]["title"]!),
            onTap: () async {
              final url = lectures[index]["url"]!;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not launch $url'),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
class LecturesPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lectures = [
     {"title": "HTML Full Course", "url": "https://youtube.com/playlist?list=PLEiEAq2VkUULq2aJA53pkSyperPfVtf7N&si=Nb_0phPTP_OLeS9q"},
   
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Videos'),
      ),
      body: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lectures[index]["title"]!),
            onTap: () async {
              final url = lectures[index]["url"]!;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not launch $url'),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
class LecturesPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lectures = [
     {"title": "C Full Course", "url": "https://youtube.com/playlist?list=PLBlnK6fEyqRggZZgYpPMUxdY1CYkZtARR&si=BxnLIkt-AhtixDb9"},
   
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Videos'),
      ),
      body: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lectures[index]["title"]!),
            onTap: () async {
              final url = lectures[index]["url"]!;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not launch $url'),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
class LecturesPage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lectures = [
     {"title": "C++ Full Course", "url": "https://youtube.com/playlist?list=PLBlnK6fEyqRh6isJ01MBnbNpV3ZsktSyS&si=KgxvCNh-pqXit2AU"},
   
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Videos'),
      ),
      body: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lectures[index]["title"]!),
            onTap: () async {
              final url = lectures[index]["url"]!;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not launch $url'),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}


class PerformanceHistogram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock performance data
    final List<SubjectPerformance> performances = [
      SubjectPerformance(subject: "HTML", score: 0.90, color: Colors.blue),
      SubjectPerformance(subject: "PYTHON", score: 0.85, color: Colors.green),
      SubjectPerformance(subject: "JAVA", score: 0.75, color: Colors.orange),
      SubjectPerformance(subject: "C", score: 0.95, color: Colors.purple),
      SubjectPerformance(subject: "C++", score: 0.80, color: Colors.red),
    ];

    return PerformanceHistogramWidget(subjectPerformances: performances);
  }
}

class SubjectPerformance {
  final String subject;
  final double score; // Assuming this is normalized between 0 and 1
  final Color color;

  SubjectPerformance({required this.subject, required this.score, required this.color});
}
class PerformanceHistogramWidget extends StatelessWidget {
  final List<SubjectPerformance> subjectPerformances;

  PerformanceHistogramWidget({required this.subjectPerformances});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Histogram",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ...subjectPerformances.map((performance) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(performance.subject),
                  ),
                  Expanded(
                    flex: 4, // Adjust the flex to manage space distribution
                    child: Container(
                      height: 20,
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: performance.score, // This is the key part
                        child: Container(
                          decoration: BoxDecoration(
                            color: performance.color,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('${(performance.score * 100).toStringAsFixed(0)}%'),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
class JavaQuizScreen extends StatefulWidget {
  @override
  _JavaQuizScreenState createState() => _JavaQuizScreenState();
}

class _JavaQuizScreenState extends State<JavaQuizScreen> {
  List<Map<String, dynamic>> questionBank = [
    {
    "question": "Which of the following is not a Java primitive type?",
    "options": ["byte", "short", "String", "float"],
    "correct_answer": "String"
},
{
    "question": "What is the size of an int in Java?",
    "options": ["8 bits", "16 bits", "32 bits", "64 bits"],
    "correct_answer": "32 bits"
},
{
    "question": "Which method is called when an object is created in Java?",
    "options": ["main()", "start()", "init()", "constructor()"],
    "correct_answer": "constructor()"
},
{
    "question": "Which of these access specifiers can be used for an interface?",
    "options": ["public", "private", "protected", "All of the above"],
    "correct_answer": "public"
},
{
    "question": "What is the default value of an object reference declared as an instance variable?",
    "options": ["null", "0", "undefined", "Not set"],
    "correct_answer": "null"
},
{
    "question": "How do you reverse a string in Java?",
    "options": [
        "Using StringBuilder or StringBuffer's reverse() method",
        "Directly using a loop and swapping characters",
        "Using Collections.reverse() on a character array",
        "Both a and b are correct"
    ],
    "correct_answer": "Both a and b are correct"
},
{
    "question": "Which of the following code snippets correctly creates a thread by implementing the Runnable interface?",
    "options": [
        "class MyThread extends Runnable { public void run() {} }",
        "class MyThread implements Runnable { public void start() {} }",
        "class MyThread implements Runnable { public void run() {} }",
        "class MyThread extends Thread { public void run() {} }"
    ],
    "correct_answer": "class MyThread implements Runnable { public void run() {} }"
},
{
    "question": "Consider the following code snippet. What will it print?\n\npublic class Test {\n    public static void main(String[] args) {\n        try {\n            int a = 0;\n            int b = 5 / a;\n        } catch (ArithmeticException e) {\n            System.out.println(\"A\");\n        } catch (Exception e) {\n            System.out.println(\"B\");\n        } finally {\n            System.out.println(\"C\");\n        }\n    }\n}",
    "options": [
        "\"A\" followed by \"C\"",
        "\"B\" followed by \"C\"",
        "\"C\" only",
        "The program throws an exception and terminates"
    ],
    "correct_answer": "\"A\" followed by \"C\""
},
{
    "question": "What is the output of the following code snippet?\n\npublic class Main {\n    public static void main(String[] args) {\n        String s1 = new String(\"Hello\");\n        String s2 = new String(\"Hello\");\n        System.out.println(s1 == s2);\n        System.out.println(s1.equals(s2));\n    }\n}",
    "options": [
        "true true",
        "true false",
        "false true",
        "false false"
    ],
    "correct_answer": "false true"
},
{
    "question": "How can you ensure that a block of code is thread-safe in Java?",
    "options": [
        "By using the synchronized keyword",
        "By avoiding the use of static variables",
        "By using the volatile keyword",
        "By using atomic variables and classes from the java.util.concurrent package"
    ],
    "correct_answer": "By using the synchronized keyword"
},
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
        title: Text("Java Quiz"),
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
class HtmlQuizScreen extends StatefulWidget {
  @override
  _HtmlQuizScreenState createState() => _HtmlQuizScreenState();
}

class _HtmlQuizScreenState extends State<HtmlQuizScreen> {
  List<Map<String, dynamic>> questionBank = [
    {
    "question": "What does HTML stand for?",
    "options": ["Hyper Text Markup Language", "Hyperlinks and Text Markup Language", "Home Tool Markup Language", "Hyper Tool Markup Language"],
    "correct_answer": "Hyper Text Markup Language"
},
{
    "question": "What is the correct HTML element for inserting a line break?",
    "options": ["<br>", "<lb>", "<break>", "<line>"],
    "correct_answer": "<br>"
},
{
    "question": "Which of the following tags is used to create a hyperlink in HTML?",
    "options": ["<a>", "<link>", "<hyperlink>", "<href>"],
    "correct_answer": "<a>"
},
{
    "question": "What is the correct HTML for creating a dropdown list?",
    "options": ["<list>", "<input type=\"dropdown\">", "<select>", "<dropdown>"],
    "correct_answer": "<select>"
},
{
    "question": "Which HTML attribute specifies an alternate text for an image, if the image cannot be displayed?",
    "options": ["alt", "title", "src", "href"],
    "correct_answer": "alt"
},
{
    "question": "How do you make a numbered list in HTML?",
    "options": ["<ul>", "<ol>", "<list>", "<dl>"],
    "correct_answer": "<ol>"
},
{
    "question": "What does CSS stand for?",
    "options": ["Cascading Style Sheets", "Creative Style Sheets", "Computer Style Sheets", "Colorful Style Sheets"],
    "correct_answer": "Cascading Style Sheets"
},
{
    "question": "Which property is used to change the background color of an element in CSS?",
    "options": ["background-color", "color", "bgcolor", "background"],
    "correct_answer": "background-color"
},
{
    "question": "How do you select an element with id 'demo' in CSS?",
    "options": ["#demo", ".demo", "demo", "element.demo"],
    "correct_answer": "#demo"
},
{
    "question": "Which of the following is a correct way to comment in HTML?",
    "options": ["<!--This is a comment-->", "//This is a comment", "#This is a comment", "/*This is a comment*/"],
    "correct_answer": "<!--This is a comment-->"
}


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
        title: Text("HTML Quiz"),
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
class CQuizScreen extends StatefulWidget {
  @override
  _CQuizScreenState createState() => _CQuizScreenState();
}

class _CQuizScreenState extends State<CQuizScreen> {
  List<Map<String, dynamic>> questionBank = [
    {
    "question": "What does the 'printf' function do in C?",
    "options": ["Reads input from the user", "Prints output to the console", "Performs mathematical operations", "Defines a variable"],
    "correct_answer": "Prints output to the console"
},
{
    "question": "What is the correct way to declare an integer variable in C?",
    "options": ["var x", "int x", "x = Integer()", "integer x"],
    "correct_answer": "int x"
},
{
    "question": "What is the purpose of the 'break' statement in a 'switch' statement?",
    "options": ["To exit the loop", "To skip to the next iteration of the loop", "To terminate the program", "To exit the switch statement"],
    "correct_answer": "To exit the switch statement"
},
{
    "question": "What is the difference between '++i' and 'i++' in C?",
    "options": ["There is no difference", "++i increments i after evaluating the expression", "++i increments i before evaluating the expression", "++i decrements i before evaluating the expression"],
    "correct_answer": "++i increments i before evaluating the expression"
},
{
    "question": "Which of the following is NOT a valid variable name in C?",
    "options": ["myVariable", "123variable", "_variable", "variable123"],
    "correct_answer": "123variable"
},
{
    "question": "What is the output of the following code?\n\n#include <stdio.h>\n\nint main() {\n    int x = 5;\n    int *ptr = &x;\n    printf(\"%d\", *ptr);\n    return 0;\n}",
    "options": ["5", "ptr", "Error", "Garbage value"],
    "correct_answer": "5"
},
{
    "question": "What does the 'sizeof' operator in C return?",
    "options": ["The size of a variable in bytes", "The size of a pointer in bytes", "The number of elements in an array", "The size of the memory allocated to a variable"],
    "correct_answer": "The size of a variable in bytes"
},
{
    "question": "What is the output of the following code?\n\n#include <stdio.h>\n\nint main() {\n    int i = 10;\n    printf(\"%d\", i++);\n    return 0;\n}",
    "options": ["10", "11", "Error", "Undefined"],
    "correct_answer": "10"
},
{
    "question": "Which keyword is used to define a constant in C?",
    "options": ["constant", "const", "define", "final"],
    "correct_answer": "const"
},
{
    "question": "What is the purpose of 'malloc' function in C?",
    "options": ["To free allocated memory", "To allocate memory dynamically", "To declare a variable", "To print formatted output"],
    "correct_answer": "To allocate memory dynamically"
}

  ]; // Use the C question bank

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
        title: Text("C Quiz"),
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
class CppQuizScreen extends StatefulWidget {
  @override
  _CppQuizScreenState createState() => _CppQuizScreenState();
}
class _CppQuizScreenState extends State<CppQuizScreen> {
  List<Map<String, dynamic>> questionBank = [
    {
    "question": "What does 'cout' do in C++?",
    "options": ["Prints to the screen", "Scans from the screen", "Prints to a file", "Scans from a file"],
    "correct_answer": "Prints to the screen"
},
{
    "question": "What is the correct syntax for declaring a variable in C++?",
    "options": ["var x", "x = 5", "int x", "x : int"],
    "correct_answer": "int x"
},
{
    "question": "What is the difference between '++i' and 'i++' in C++?",
    "options": ["There is no difference", "++i increments i before evaluating the expression", "++i increments i after evaluating the expression", "++i decrements i before evaluating the expression"],
    "correct_answer": "++i increments i before evaluating the expression"
},
{
    "question": "What does the 'const' keyword do in C++?",
    "options": ["Declares a constant variable", "Defines a class", "Allocates memory", "Throws an exception"],
    "correct_answer": "Declares a constant variable"
},
{
    "question": "What is the output of the following code?\n\n#include <iostream>\n\nint main() {\n    int x = 5;\n    int *ptr = &x;\n    std::cout << *ptr;\n    return 0;\n}",
    "options": ["5", "ptr", "Error", "Garbage value"],
    "correct_answer": "5"
},
{
    "question": "What is the purpose of the 'new' operator in C++?",
    "options": ["To delete allocated memory", "To allocate memory dynamically", "To declare a new variable", "To print formatted output"],
    "correct_answer": "To allocate memory dynamically"
},
{
    "question": "Which of the following is NOT a valid variable name in C++?",
    "options": ["myVariable", "123variable", "_variable", "variable123"],
    "correct_answer": "123variable"
},
{
    "question": "What is the output of the following code?\n\n#include <iostream>\n\nint main() {\n    int i = 10;\n    std::cout << i++;\n    return 0;\n}",
    "options": ["10", "11", "Error", "Undefined"],
    "correct_answer": "10"
},
{
    "question": "What is the purpose of 'virtual' keyword in C++?",
    "options": ["To create an abstract class", "To override a base class function", "To specify a base class destructor", "To allocate memory"],
    "correct_answer": "To override a base class function"
},
{
    "question": "What does the 'this' pointer refer to in C++?",
    "options": ["Pointer to the current object", "Pointer to the previous object", "Pointer to the next object", "Pointer to the base object"],
    "correct_answer": "Pointer to the current object"
}

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
        title: Text("C++ Quiz"),
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

import 'package:flutter/material.dart';
import 'package:flutter_application_login/screens/comdata.dart';

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

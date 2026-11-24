import 'package:flutter/material.dart';
import 'package:flutter_application_login/screens/comdata.dart';

class HomePage extends StatefulWidget {
 
  @override
  State<HomePage> createState() => _HomePageState();
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
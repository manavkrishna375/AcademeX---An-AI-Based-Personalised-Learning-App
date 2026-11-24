import 'package:flutter/material.dart';
import 'package:flutter_application_login/admin/adminlist.dart';
import 'package:flutter_application_login/admin/dem.dart';
import 'package:flutter_application_login/provider/mainprovider.dart';
import 'package:provider/provider.dart';



class HomePage extends StatelessWidget {
  // In a real application, you might check if the user is an admin using a state management solution or a provider.
  final bool isAdmin = true;  // This should be determined by your authentication logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to a normal user page
              },
              child: Text('Go to User Page'),
            ),
            if (isAdmin)  // Only show this button if the user is an admin
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage()),
                  );
                },
                child: Text('Go to Admin Page'),
              ),
          ],
        ),
      ),
    );
  }
}

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdmPage()),
                  );
              },
              child: Text('Category'),
            ),
            SizedBox(height: 16), // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BlankPage()),
                  );
              },
              child: Text('Questions'),
            ),
          ],
        ),
      ),
    );
  }
}

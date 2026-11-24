import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_login/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class admindata extends StatelessWidget {
  const admindata({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField and Button Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer<MainProvider>(
              builder: (context,value,child) {
                return TextField(
                  controller: value.categorycontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter text',
                    border: OutlineInputBorder(),
                  ),
                );
              }
            ),
            SizedBox(height: 16),
           Consumer<MainProvider>(
              builder: (context,value,child) {
                return ElevatedButton(
                  onPressed: () {
                    value.addcategory();
                    value.getcategor();
                    Navigator.pop(context);

                    // Action to be performed when the button is pressed
                    // You can add more functionality here
                  },
                  child: Text('Submit'),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
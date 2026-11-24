import 'package:flutter/material.dart';
import 'package:flutter_application_login/admin/quesans.dart';
import 'package:flutter_application_login/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blank Page'),
      ),
      body: Center(
        child: Text(
          'This is a blank page.',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: Consumer<MainProvider>(
        builder: (context,value,child) {
          return FloatingActionButton(
            onPressed: () {
              value.getcategor();
              
               Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TextFieldPage()),
                      );
            },
            child: Icon(Icons.add),
          );
        }
      ),
    );
  }
}

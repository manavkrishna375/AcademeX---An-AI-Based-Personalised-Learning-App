import 'package:flutter/material.dart';
import 'package:flutter_application_login/admin/admindata.dart';
import 'package:flutter_application_login/provider/mainprovider.dart';
import 'package:provider/provider.dart';


class AdmPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdmPage> {
  // Current selected category
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body:  Consumer<MainProvider>(
        builder: (context,value,child) {
          return ListView.builder(
            itemCount: value.categorylist.length,
            
            itemBuilder: (context, index) {
              var item =value.categorylist[index];
              return Container(
                height: 100,
                width: 150,
                child: Center(
                  child: Text(item.name
                            ),
                ),
          
              );
            },);
        }
      ),
        
        
     
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => admindata()),
                  );
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      )
    );
  }


}

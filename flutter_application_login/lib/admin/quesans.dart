import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_login/model/modelclass.dart';
import 'package:flutter_application_login/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class TextFieldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Fields Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<MainProvider>(
          builder: (context,value,child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            
                      Autocomplete<category>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return value.categorylist
                          .where((category item) => item.name
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()))
                          .toList();
                    },
                    displayStringForOption: (category option) =>
                        option.name,
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        fieldTextEditingController.text = value.categoryct.text;
                      });
            
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: TextFormField(
                              cursorColor: Colors.brown,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w200),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Category name",
                                hintStyle: const TextStyle(
                                    color: Colors.black45, fontFamily: 'cantata'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (txt) {},
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                            ),
                          ),
                        ),
                      );
                    },
                    onSelected: (category selection) {
                      value.categoryct.text = selection.name;
                      value.selectcategoryid = selection.id;
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<category> onSelected,
                        Iterable<category> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)),
                            width: 200,
                            height: 200,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(10.0),
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final category option = options.elementAt(index);
            
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            // border: Border(left: BorderSide(color: Colors.white,width: .6,
                                            // ))
                                            ),
                                        height: 30,
                                        width: 200,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Text(option.name,
                                                    style: const TextStyle(
                                                      fontFamily: 'cantata',
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ]),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            
                TextFieldWidget(label: 'Questions', Controller: value.questioncontroller,),
                TextFieldWidget(label: 'Answers',Controller: value.answercontroller),
                TextFieldWidget(label: 'Option 1',Controller: value.option1controller),
                TextFieldWidget(label: 'Option 2',Controller: value.option2controller),
                TextFieldWidget(label: 'Option 3',Controller: value.option3controller),
                TextFieldWidget(label: 'Option 4',Controller: value.option4controller),
              ],
            );
          }
        ),
      ),
      floatingActionButton: Consumer<MainProvider>(
        builder: (context,value,child) {
          return FloatingActionButton(
            onPressed: () {
              value.addquestions();
                
            },
            child: Icon(Icons.add),
          );
        }
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String label;
 TextEditingController Controller;
 
   TextFieldWidget({Key? key, required this.label,required this.Controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: Controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

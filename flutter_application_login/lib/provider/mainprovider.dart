import 'dart:collection';
import 'dart:js_util';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_login/model/modelclass.dart';

class MainProvider extends ChangeNotifier{
 

 FirebaseFirestore db= FirebaseFirestore.instance;
 TextEditingController categorycontroller = TextEditingController();


 void addcategory(){
  String id = DateTime.now().millisecondsSinceEpoch.toString();
   Map<String, dynamic> map =HashMap();
  map["CATEGORY_ID"]=id;
  map["CATEGORY_NAME"]=categorycontroller.text;
  db.collection("COURSES").doc(id).set(map);
  getcategor();
  notifyListeners();
 }
 List<category> categorylist=[];

 void getcategor(){
  db.collection("COURSES").get().then((value) {
    if(value.docs.isNotEmpty){
      for(var element in value.docs){
        Map<String, dynamic> getmap=element.data();
        categorylist.add(category(
          getmap["CATEGORY_ID"].toString(),
           getmap["CATEGORY_NAME"].toString()));
           notifyListeners();

      }
    }
    notifyListeners();
  });
 }

  String selectcategoryid="";

 TextEditingController categoryct =TextEditingController();
 TextEditingController questioncontroller=TextEditingController();
 TextEditingController answercontroller=TextEditingController();
 TextEditingController option1controller=TextEditingController();
 TextEditingController option2controller=TextEditingController();
 TextEditingController option3controller=TextEditingController();
 TextEditingController option4controller=TextEditingController();

  void addquestions(){
  String id = DateTime.now().millisecondsSinceEpoch.toString();
   Map<String, dynamic> map =HashMap();
  map["QUESTION_ID"]=id;
  map["QUESTIONS"]=questioncontroller.text;
  map["ANSWER"]=answercontroller.text;
  map["CATEGORY_NAME"]=categoryct.text;
   map["CATEGORY_ID"]=selectcategoryid;
   map["OPTIONS"]=[option1controller.text,option2controller.text,option3controller.text,option4controller.text];
  db.collection("QUESTIONS").doc(id).set(map);
 
}


 










}
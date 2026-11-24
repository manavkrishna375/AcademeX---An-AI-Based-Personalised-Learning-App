import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_login/admin/adminhomescreen.dart';
import 'package:flutter_application_login/provider/control.dart';
import 'package:flutter_application_login/provider/mainprovider.dart';
import 'package:flutter_application_login/screens/signin_screen.dart';
import 'package:flutter_application_login/screens/signup_screen.dart';
import 'package:provider/provider.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
Future<void> main() async {
  if(!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }else {
    await Firebase.initializeApp(
         options:const FirebaseOptions(
         apiKey: "AIzaSyAYfAaP2NON8Rs9tdCa9RsWgz4QgovDevs",
         authDomain: "academex-dfa37.firebaseapp.com",
         projectId: "academex-dfa37",
         storageBucket: "academex-dfa37.appspot.com",
         messagingSenderId: "300967511662",
         appId: "1:300967511662:web:97b7965064d2407547087f",
         measurementId: "G-17GJ866Y82"
        ));}
    runApp(const MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create:  (context) => Loginprovider(),),
      ChangeNotifierProvider(create: (context) => MainProvider(),)
    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage()
      ),
    );
  }
}


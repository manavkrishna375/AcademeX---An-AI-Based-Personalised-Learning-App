import 'package:flutter/material.dart';
import 'package:flutter_application_login/main.dart';
import 'package:flutter_application_login/provider/control.dart';
import 'package:flutter_application_login/reusable_widget/reusable_widget.dart';
import 'package:flutter_application_login/screens/comdata.dart';
import 'package:flutter_application_login/screens/home_screen.dart';
import 'package:flutter_application_login/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart'; // Import Firebase Authentication

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) :super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Consumer<Loginprovider>(
                  builder: (context,value,child) {
                    return reusableTextField("enter username", Icons.person_outline, false, value.usernameTextController);
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<Loginprovider>(
                  builder: (context,value1,child) {
                    return reusableTextField("enter Email Id", Icons.person_outline, false,value1.emailTextController);
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
               Consumer<Loginprovider>(
                  builder: (context,value2,child) {
                    return reusableTextField("enter password", Icons.lock_outlined, true, value2.passwordTextController);
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                 Consumer<Loginprovider>(
                  builder: (context,value1,child) {
                    return signInSignUpButton(context, false, () {
                      value1.signupUser(
                                    value1.emailTextController.text, value1.passwordTextController.text,value1.usernameTextController.text, context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>quizpage()),
                        );
                    
                      // FirebaseAuth.instance
                      //     .createUserWithEmailAndPassword(
                      //         email: _emailTextController.text, password: _passwordTextController.text)
                      //     .then((value) {
                      //   print("created new account");
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => const HomeScreen()),
                      //   );
                      // }).catchError((error) {
                      //   print("error ${error.toString()}");
                      // });
                    });
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

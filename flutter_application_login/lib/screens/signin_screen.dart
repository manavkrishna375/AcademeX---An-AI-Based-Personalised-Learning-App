import 'package:flutter/material.dart';
import 'package:flutter_application_login/main.dart';
import 'package:flutter_application_login/provider/control.dart';
import 'package:flutter_application_login/reusable_widget/reusable_widget.dart';
import 'package:flutter_application_login/screens/comdata.dart';
import 'package:flutter_application_login/screens/signup_screen.dart';
import 'package:flutter_application_login/screens/home_screen.dart';
import 'package:flutter_application_login/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart'; // Import Firebase Authentication

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLogin=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [hexStringToColor("3B8BEA"), hexStringToColor("9546C4"), hexStringToColor("5E61F4")],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/applogo.png"),
                const SizedBox(
                  height: 30,
                ),
                Consumer<Loginprovider>(
                  builder: (context,value,child) {
                    return reusableTextField("enter email", Icons.person_outline, false, value.emailTextController);
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<Loginprovider>(
                  builder: (context,value,child) {
                    return reusableTextField("enter password", Icons.lock_outline, true, value.passwordTextController);
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                 Consumer<Loginprovider>(
                  builder: (context,value1,child) {
                    return signInSignUpButton(context, true, () {
                              isLogin
                            ? value1.signinUser(value1.emailTextController.text, value1.passwordTextController.text ,context)
                            : Navigator.push(context, MaterialPageRoute(builder: (context) => SelectionPage(),));

                        //      Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                        // );





                      
                      
                    
            // FirebaseAuth.instance.
                         
                      //     .then((value) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => const HomeScreen()),
                      //   );
                      // }).catchError((error) {
                      //   print("error ${error.toString()}");
                      // });
                    });
                  }
                ),
                textbutton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textbutton() {
    return  TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin=="SIGNUP"?
                       Navigator.push(  context,
                       MaterialPageRoute(builder: (context) => const SignUpScreen()),):
                      isLogin = !isLogin;

                    });
                  },
                  child: Text(isLogin
                      ?  "Don't have an account? SIGNUP"
                      : "Already have an account? LOGIN"));
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     const Text(
    //       "Don't have account?",
    //       style: TextStyle(color: Colors.white70),
    //     ),
    //     GestureDetector(
    //       onTap: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => const SignUpScreen()),
    //         );
    //       },
    //       child: const Text(
    //         "Sign Up",
    //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    //       ),
    //     )
    //   ],
    // );
  }
}

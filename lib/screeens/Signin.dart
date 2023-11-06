// ignore_for_file: file_names, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:socialmedia/common/Message_Bar.dart';
import 'package:socialmedia/common/bottombar.dart';
import 'package:socialmedia/common/text_field_input.dart';
import 'package:socialmedia/screeens/Signup.dart';
import 'package:svg_flutter/svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    var phoneWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  'assets/login.svg',
                  height: phoneHeight / 2 - 50,
                ),
              ),
              Text(
                "Let's Login",
                style: GoogleFonts.aBeeZee(fontSize: 23),
              ),
              const SizedBox(
                height: 30,
              ),
              textFieldInput(
                controller: _username,
                hint_text: "Enter Your Email",
                obscuretext: false,
              ),
              const SizedBox(
                height: 15,
              ),
              textFieldInput(
                controller: _password,
                hint_text: "Enter Password",
                obscuretext: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Passoword ?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 34, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                email: _username.text,
                                password: _password.text,
                              );

                              User? user = userCredential.user;

                              print('Signed in: ${user!.uid}');
                              showEmailNotExistSnackBar(
                                context,
                                "Login Successfully",
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomBar()),
                              );
                            } catch (e) {
                              print('Credentials Not Match');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, elevation: 7),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: SizedBox(
                        // width: MediaQuery.of(context).size.width - 80,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, elevation: 7),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

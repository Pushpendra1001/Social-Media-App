import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/auth/authentication.dart';
import 'package:socialmedia/common/showBar.dart';

import 'package:socialmedia/common/text_field_input.dart';
import 'package:socialmedia/screeens/Signin.dart';
import 'package:socialmedia/utils/imagePicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _bio = TextEditingController();
  Uint8List? _Image;

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    _Image = img;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(children: [
            _Image != null
                ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_Image!),
                  )
                : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1682687982167-d7fb3ed8541d?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8"),
                  ),
            Positioned(
                bottom: -1,
                left: 90,
                child: IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () {
                    selectImage();
                  },
                )),
            const SizedBox(
              height: 100,
            ),
          ]),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          "Let's Create a new account",
          style: GoogleFonts.aBeeZee(fontSize: 23),
        ),
        const SizedBox(
          height: 50,
        ),
        textFieldInput(
          controller: _username,
          hint_text: "Create your Username ",
          obscuretext: false,
        ),
        const SizedBox(
          height: 15,
        ),
        textFieldInput(
          controller: _email,
          hint_text: "Enter Your Email",
          obscuretext: false,
        ),
        const SizedBox(
          height: 15,
        ),
        textFieldInput(
          controller: _password,
          hint_text: "Create Your Password",
          obscuretext: true,
        ),
        const SizedBox(
          height: 15,
        ),
        textFieldInput(
          controller: _bio,
          hint_text: "Write Your Bio",
          obscuretext: false,
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, elevation: 7),
              child: const Text(
                "Create Account",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                Authentications().signUpUser(
                    userName: _username.text,
                    email: _email.text,
                    password: _password.text,
                    bio: _bio.text,
                    file: _Image!);

                Future.delayed(const Duration(seconds: 3));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ));
              },
            ))
      ]),
    );
  }
}

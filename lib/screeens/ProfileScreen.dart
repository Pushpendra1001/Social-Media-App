// ignore_for_file: file_names

import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/screeens/Signin.dart';

import '../utils/imagePicker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getuser();
  }

  String userName = "Not Found";
  String photoUrl = "Not Fount";
  String bio = "Not Found";
  Uint8List? _Image;
  String ModelUid = "Not Fount";

  void getuser() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      userName = (snap.data() as Map<String, dynamic>)['userName'];
      photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
      bio = (snap.data() as Map<String, dynamic>)['bio'];
      ModelUid = (snap.data() as Map<String, dynamic>)['bio'];

      print(userName);
      print(photoUrl);
      print(bio);
    });
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    _Image = img;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    )));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(children: [
              _Image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_Image!),
                    )
                  : CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(photoUrl),
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(userName,
                  style: GoogleFonts.aboreto(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Center(
              child: Text(bio,
                  style: GoogleFonts.aboreto(
                    fontSize: 15,
                  )),
            ),
            const SizedBox(height: 50),
            Text(
              "Your Uploads",
              style: GoogleFonts.aboreto(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy("postUrl", descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MasonryGridView.count(
                      itemCount: snapshot.data!.docs.length,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        if (snapshot.data!.docs[index].data()["username"] ==
                            userName) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                                snapshot.data!.docs[index].data()["postUrl"]),
                          );
                        } else {
                          return const SizedBox(
                            height: 0,
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

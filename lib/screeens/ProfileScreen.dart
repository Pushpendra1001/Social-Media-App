import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/imagePicker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getuser();
  }

  String userName = "eeee";
  String photoUrl = "eeee";
  String bio = "eeee";
  Uint8List? _Image;

  void getuser() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      userName = (snap.data() as Map<String, dynamic>)['userName'];
      photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
      bio = (snap.data() as Map<String, dynamic>)['bio'];

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                  itemCount: 7,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/image$index.jpeg"),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

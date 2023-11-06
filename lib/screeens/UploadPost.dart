// ignore_for_file: unused_import, file_names, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/auth/firebaseModel.dart';
import 'package:socialmedia/common/postCard.dart';
import 'package:socialmedia/screeens/HomeScreen.dart';
import 'package:socialmedia/utils/imagePicker.dart';
import 'package:socialmedia/auth/firebaseModel.dart';
import 'package:socialmedia/auth/firestore.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

Uint8List? _file;
bool isLoading = false;
String userName = "Not Found";
String MyImage = "Not Found";
String bio = "Not Found";
String uid = "Not Fount";
Uint8List? Image;

class _UploadPostState extends State<UploadPost> {
  @override
  void initState() {
    // TODO: implement initState

    getuser();
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);

                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void getuser() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(
      () {
        setState(() {
          userName = (snap.data() as Map<String, dynamic>)['userName'];
          MyImage = (snap.data() as Map<String, dynamic>)['photoUrl'];
          bio = (snap.data() as Map<String, dynamic>)['bio'];
          uid = (snap.data() as Map<String, dynamic>)['uid'];
        });

        print(userName);
        print(MyImage);
        print(bio);
      },
    );
  }

  void postImage(String uid, String username, String MyImage) async {
    setState(() {});
    // start the loading
    try {
      // upload to storage and db
      String res =
          await FirestoreMethods().uploadPost(_file!, uid, username, MyImage);

      if (res == "success") {
        setState(() {
          isLoading = false;
        });
      } else {
        if (context.mounted) {}
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: InkWell(
            onTap: () {
              _selectImage(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          size: 64,
                        ),
                        Text(
                          "Create Your Post",
                          style: TextStyle(fontSize: 24),
                        ),
                        Icon(
                          Icons.file_upload_outlined,
                          size: 64,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: const ButtonStyle(),
                    onPressed: () {
                      postImage(uid, userName, MyImage);
                    },
                    child: const Text("Upload"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

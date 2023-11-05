import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/common/Message_Bar.dart';
import 'package:socialmedia/screeens/Signin.dart';
import 'package:socialmedia/storage/mystorage.dart';

class Authentications {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String message = "Something is wrong";

  Future<String> signUpUser({
    required String userName,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String photoUrl =
          await Storage().uploadImageToStorage('users', file, false);

      _firestore.collection("users").doc(credential.user!.uid).set({
        'userName': userName,
        'email': email,
        'bio': bio,
        'uid': credential.user!.uid,
        'photoUrl': photoUrl,
      });

      message = "Account Created successfully";
      return message;
    } catch (e) {
      print(message);
      return message;
    }
  }
}

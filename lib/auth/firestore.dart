import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/auth/firebaseModel.dart';
import 'package:socialmedia/auth/models/Posts.dart';
import 'package:socialmedia/storage/mystorage.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    Uint8List file,
    String uid,
    String username,
    String MyImage,
  ) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String postUrl = await StorageMode().UploadImage('posts', file, true);
      String MypostId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        dislikes: "0",
        uid: uid,
        username: username,
        likes: "0",
        MypostId: MypostId,
        postUrl: postUrl,
        MyImage: MyImage,
      );
      _firestore.collection('posts').doc(MypostId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

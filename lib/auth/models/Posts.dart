import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String MypostId;
  final String username;
  final String postUrl;
  final String MyImage;
  final String likes;
  final String dislikes;

  const Post({
    required this.uid,
    required this.username,
    required this.likes,
    required this.MypostId,
    required this.dislikes,
    required this.postUrl,
    required this.MyImage,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        uid: snapshot["uid"],
        likes: snapshot["likes"],
        MypostId: snapshot["MyPostId"],
        dislikes: snapshot["dislike"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        MyImage: snapshot['MyImage']);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "likes": likes,
        "username": username,
        "MypostId": MypostId,
        "dislikes": dislikes,
        'postUrl': postUrl,
        'MyImage': MyImage
      };
}

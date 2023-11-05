import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialmedia/screeens/ProfileScreen.dart';
import 'package:socialmedia/utils/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  void initState() {
    // TODO: implement initState
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(
          "Social",
          style: GoogleFonts.gabriela(fontSize: 36),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.moon)),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      // backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  backgroundImage: NetworkImage(photoUrl)),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userName),
                                  Text(bio),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.handshake_outlined))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Image.asset("assets/image$index.jpeg"),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_upward_rounded)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_downward_rounded)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.bookmark_add_outlined)),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.report)),
                          ],
                        )
                      ]),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

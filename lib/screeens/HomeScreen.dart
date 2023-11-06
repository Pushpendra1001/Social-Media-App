// ignore_for_file: unused_import, non_constant_identifier_names, unused_field, unused_local_variable, file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialmedia/common/postCard.dart';
import 'package:socialmedia/screeens/ProfileScreen.dart';
import 'package:socialmedia/utils/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
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
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(CupertinoIcons.moon)),
          const SizedBox(
            width: 10,
          ),
          // const CircleAvatar(
          //   backgroundImage: NetworkImage("assets/image2.jpeg"),
          // ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      // backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
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
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  // height: 400,
                  child: postCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

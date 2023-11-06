import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class postCard extends StatefulWidget {
  final snap;
  const postCard({super.key, required this.snap});

  @override
  State<postCard> createState() => _postCardState();
}

class _postCardState extends State<postCard> {
  // ...

  @override
  Widget build(BuildContext context) {
    bool like = false;
    bool unlike = false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.snap?["MyImage"]),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.snap?["username"] ?? " "), // Added null check here
                  Text(widget.snap?[" "] ?? " "), // Added null check here
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline)),
                ],
              )
            ],
          ),
        ),
        Image.network(
          widget.snap!["postUrl"] ?? " ",
        ),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_down)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_add_outlined)),
            // const Spacer(),
            // IconButton(onPressed: () {}, icon: const Icon(Icons.face),),
          ],
        )
      ]),
    );
  }
}

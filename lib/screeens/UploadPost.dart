import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/screeens/HomeScreen.dart';
import 'package:socialmedia/utils/imagePicker.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

Uint8List? _file;

class _UploadPostState extends State<UploadPost> {
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
            )
          ],
        );
      },
    );
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
            child: Container(
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
          ),
        ),
      ),
    );
  }
}

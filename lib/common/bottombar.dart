import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/screeens/UploadPost.dart';
import 'package:socialmedia/screeens/HomeScreen.dart';
import 'package:socialmedia/screeens/ProfileScreen.dart';
import 'package:socialmedia/screeens/SearchScreen.dart';
import 'package:socialmedia/screeens/Signin.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomeScreen(),
          UploadPost(),
          SearchScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 60,
        backgroundColor: Colors.white10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? Colors.black : Colors.white,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.post_add,
                color: (_page == 1) ? Colors.black : Colors.white,
              ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: (_page == 2) ? Colors.black : Colors.white,
              ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 3) ? Colors.black : Colors.white,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}

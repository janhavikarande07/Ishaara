import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shreya/Achievements.dart';
import 'package:shreya/Explore/Explore.dart';
import 'package:shreya/Profile/Profile.dart';
import 'package:shreya/colors.dart';

import 'Home.dart';

const Color bottonNavBgColor = Color(0xFF17203A);

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() =>
      HomePageState();
}

class HomePageState extends State<HomePage>{
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    Home(),
    Explore(),
    Achievements(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFF),
            border: Border(
              top: BorderSide(
              color: themeColor,
              width: 2.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: GNav(
              gap: 8,
              activeColor: Colors.white,
              color: themeColor,
              iconSize: 28,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              duration: Duration(milliseconds: 800),
              tabBackgroundColor: darkThemeColor,
              tabs: [
                GButton(
                  icon: FontAwesomeIcons.houseChimney,
                  text: 'Home',
                ),
                GButton(
                  icon: FontAwesomeIcons.magnifyingGlass,
                  text: 'Explore',
                ),
                GButton(
                  icon: FontAwesomeIcons.award,
                  text: 'Achievements',
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
            ),
          ),
        ),
      );
  }
}
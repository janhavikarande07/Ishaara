import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shreya/values_.dart';
import 'package:super_tooltip/super_tooltip.dart';

import 'Learning Phase/AlphabetsLevelPage.dart';
import 'Learning Phase/DigitsLevelPage.dart';
import 'Testing Phase/TestingLevelPage.dart';
import 'colors.dart';
import 'Testing Phase/testing_Q1.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> levelData = {};
  bool allowed = false;

  Future<void> getData() async {
    DocumentReference docRef = FirebaseFirestore.instance.collection("Users").doc(user!.uid);
    DocumentSnapshot snapshot = await docRef.get();
    if (snapshot.exists) {
      dynamic fieldValue = snapshot.data();
      if (fieldValue != null) {
        setState(() {
          levelData.addAll(fieldValue);
        });
      }
    }
  }

  final _controller = SuperTooltipController();
  Future<bool>? _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (_controller.isVisible) {
      await _controller.hideTooltip();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homePage_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children : [
                  Image(
                    image: AssetImage("assets/ishaara_logo.png"),
                    height: 80,
                  ),
                  (lives == 0) ?
                  GestureDetector(
                    onTap: () async {
                      await _controller.showTooltip();
                    },
                    child: SuperTooltip(
                      showBarrier: true,
                      controller: _controller,
                      content: const Text(
                        "Come back tomorrow for a full set of lives!",
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/honey_jar.png", width: 30, height: 50,),
                          Container(
                            child: Text("$lives", style: TextStyle(fontFamily: "Cooper", fontWeight: FontWeight.w700, fontSize: 20),)
                          ),
                        ],
                      ),
                    ),
                  ) : Row(
                    children: [
                      Image.asset("assets/honey_jar.png", width: 30, height: 50,),
                      Container(
                          child: Text("$lives", style: TextStyle(fontFamily: "Cooper", fontWeight: FontWeight.w700, fontSize: 20),)
                      ),
                    ],
                  ),
                ]
              ),
            ),
            Spacer(),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: themeColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AlphabetsPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            minimumSize: const Size(120, 100),
                            // textStyle: TextStyle(fontSize: 14),
                            shadowColor: yellowishOrange,
                            elevation: 5,
                          ),
                          child: const Text(
                            "Alphabets",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Cooper",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DigitsPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            minimumSize: const Size(120, 100),
                            // textStyle: TextStyle(fontSize: 14),
                            shadowColor: yellowishOrange,
                            elevation: 5,
                          ),
                          child: const Text(
                            "Numbers",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Cooper",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -17,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      color: Colors.white,
                      child: Text(
                        'Learning Phase',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Cooper",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.all(50),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: themeColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      getData();

                      if(current_learning_alphabets_level > 20 && current_learning_digits_level > 9) {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TestingPage(),
                          ),
                        );
                      }
                      else{
                        _showCompletionDialog(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      minimumSize: const Size(double.infinity, 100),
                      // textStyle: TextStyle(fontSize: 14),
                      shadowColor: yellowishOrange,
                      elevation: 5,
                    ),
                    child: const Text(
                      "Assessments",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Cooper",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -17,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      color: Colors.white,
                      child: Text(
                        'Testing Phase',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Cooper",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: lightThemeColor,
          title: Text('Unlock the Testing Phase', style: TextStyle(fontWeight: FontWeight.w700),),
          content: Text('To unlock the Testing Phase, complete at least 20 Alphabet Levels and 9 Number Levels in the Learning Phase. \nKeep going—you’re almost there!'
          ,style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

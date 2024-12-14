import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shreya/BottomNav.dart';
import '../db_tasks.dart';
import '../values_.dart';
import 'TestingLevelPage.dart';
import '../Learning Phase/a_Q2.dart';

import '../colors.dart';
import 'testing_Q2.dart';

class Testing_Q1 extends StatefulWidget {
  final int current_level;
  const Testing_Q1({Key? key, required this.current_level}) : super(key: key);
  @override
  State<Testing_Q1> createState() => Testing_Q1State();
}

class Testing_Q1State extends State<Testing_Q1> {
  double _width = 250;
  double percent = 1/3;
  int trial = 1;

  List<String> question_testing = [];
  List<dynamic> buttonStates = [Colors.white, Colors.white, Colors.white, Colors.white];
  bool isAnswerCorrect = false;
  String question = "";
  String type = "alphabets";

  Map<String, dynamic> data = {};
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Random random = Random();
    testing.shuffle(random);
    question_testing.add(testing[0]);
    question_testing.add(testing[7]);
    question_testing.add(testing[21]);
    question_testing.add(testing[13]);
    question = question_testing[1];
    question_testing.shuffle(random);
  }

  void changeBackgroundColor(String answer, int no) {
    setState(() {
      if (answer == question) {
        for (int i = 0; i < 4; i++) {
          if ((i + 1) == no) {
            buttonStates[i] = themeColor;
          } else {
            buttonStates[i] = Colors.white;
          }
        }
        isAnswerCorrect = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Correct Answer!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        for (int i = 0; i < 4; i++) {
          if (i + 1 == no) {
            buttonStates[i] = Colors.red;
          } else {
            buttonStates[i] = Colors.white;
          }
        }

        setState(() async {
          isAnswerCorrect = false;
          lives--;
          trial++;
          if(lives == 0){
            _showMyDialog();
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect Answer!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("You’ve run out of lives!", textAlign: TextAlign.center,  style: TextStyle(fontWeight: FontWeight.w500),),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Come back tomorrow for a full set of lives!", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              child:
              ElevatedButton(
                onPressed: () async {
                  await updateUser(user?.uid, {"lives" : lives});
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  HomePage()));
                },
                child: Text("OK", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFF5DEDE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  minimumSize: const Size(130, 40),
                  // textStyle: TextStyle(fontSize: 14),
                  shadowColor: Color(0XFFF5DEDE),
                  elevation: 5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _width = percent * 250;
      });
    });

    return Scaffold(
      body :Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height : 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: ()async {
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TestingPage(),
                    ),
                  );
                },
                  icon: Icon(Icons.close, size: 30, weight: 50,),
                ),
                Stack(
                  children: [
                    Container(
                      width: 250,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFCFE2F3)),
                    ),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        width: _width,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: themeColor)
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                Image.asset("assets/honey_jar.png", width: 30, height: 50,),
                Text(lives.toString(), style: TextStyle(fontFamily: "Cooper", fontWeight: FontWeight.w700, fontSize: 20),)
              ],
            ),
            SizedBox(height: 50),
            Text("What sign represents ${question}? ",
              style: TextStyle(
                fontFamily: "Cooper",
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    changeBackgroundColor(question_testing[0], 1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: buttonStates[0],
                      border: Border.all(
                        color: themeColor,
                        width: 2.0,
                      ),
                    ),
                    child: (alphabets.contains(question_testing[0])) ?
                    Image.asset(
                      'assets/alphabets/${question_testing[0]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ) : Image.asset(
                      'assets/digits/${question_testing[0]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    changeBackgroundColor(question_testing[1], 2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: buttonStates[1],
                      border: Border.all(
                        color: themeColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: (alphabets.contains(question_testing[1])) ?
                    Image.asset(
                      'assets/alphabets/${question_testing[1]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ) : Image.asset(
                      'assets/digits/${question_testing[1]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    changeBackgroundColor(question_testing[2], 3);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: buttonStates[2],
                      border: Border.all(
                        color: themeColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: (alphabets.contains(question_testing[2])) ?
                    Image.asset(
                      'assets/alphabets/${question_testing[2]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ) : Image.asset(
                      'assets/digits/${question_testing[2]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    changeBackgroundColor(question_testing[3], 4);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: buttonStates[3],
                      border: Border.all(
                        color: themeColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: (alphabets.contains(question_testing[3])) ?
                    Image.asset(
                      'assets/alphabets/${question_testing[3]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ) : Image.asset(
                      'assets/digits/${question_testing[3]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: isAnswerCorrect
                  ? () async {

                setState(() {
                  if(trial == 1) {
                    testing_levels["${widget.current_level}"]++;
                  }
                });

                try {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Testing_Q2(current_level : widget.current_level),
                    ),
                  );
                }
                on Exception catch (e){
                  print("Error");
                }
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isAnswerCorrect ? themeColor : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                minimumSize: const Size(double.infinity, 50),
                shadowColor: yellowishOrange,
                elevation: 5,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "Cooper",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

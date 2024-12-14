import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shreya/Testing%20Phase/testing_Q3.dart';
import '../BottomNav.dart';
import '../db_tasks.dart';
import '../values_.dart';
import 'TestingLevelPage.dart';

import '../colors.dart';

class Testing_Q2 extends StatefulWidget {
  final int current_level;
  const Testing_Q2({Key? key, required this.current_level}) : super(key: key);
  @override
  State<Testing_Q2> createState() => Testing_Q2State();
}

class Testing_Q2State extends State<Testing_Q2> {
  double _width = 250;
  double percent = 2/3;
  int trial = 1;

  List<String> question_testing = [];
  List<dynamic> buttonStates = [Colors.white, Colors.white, Colors.white];
  bool isAnswerCorrect = false;
  String question = "";
  String type = "alphabets";

  Map<String, dynamic> data = {};

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getData() async {
    DocumentReference docRef =
    FirebaseFirestore.instance.collection("Users").doc(user!.uid);
    DocumentSnapshot snapshot = await docRef.get();
    if (snapshot.exists) {
      dynamic fieldValue = snapshot.data();
      if (fieldValue != null) {
        setState(() {
          data.addAll(fieldValue);
        });
        print(data);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Random random = Random();
    testing.shuffle(random);
    question_testing.add(testing[0]);
    question_testing.add(testing[7]);
    question_testing.add(testing[21]);
    question = question_testing[0];
    question_testing.shuffle(random);
    if(digits.contains(question)){
      type = "digits";
    }
    getData();
  }

  void changeBackgroundColor(String answer, int no) {
    setState(() {
      if (answer == question) {
        for (int i = 0; i < 3; i++) {
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
        for (int i = 0; i < 3; i++) {
          if (i + 1 == no) {
            buttonStates[i] = Colors.red;
          } else {
            buttonStates[i] = Colors.white;
          }
        }
        setState(() async {
          isAnswerCorrect = false;
          lives--;
          if(lives == 0){
            _showMyDialog();
          }
          trial++;
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
            Text("What ${type.substring(0, type.length-1)} does this sign represent? ",
              style: TextStyle(
                fontFamily: "Cooper",
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30,),
            Image.asset("assets/$type/${question}.png", width: 200, height: 150,),
            SizedBox(height: 20,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: buttonStates[0],
                    side: BorderSide(
                      color: themeColor,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  ),
                  onPressed: () => changeBackgroundColor(question_testing[0], 1),
                  child: Text('${question_testing[0].toUpperCase()}',style: TextStyle(
                    fontFamily: "Cooper",
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,),
                ),
                SizedBox(width: 30),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: buttonStates[1],
                    side: BorderSide(
                      color: themeColor,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  ),
                  onPressed: () => changeBackgroundColor(question_testing[1], 2),
                  child: Text('${question_testing[1].toUpperCase()}',
                    style: TextStyle(
                      fontFamily: "Cooper",
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,),
                ),
              ],
            ),
            SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: buttonStates[2],
                side: BorderSide(
                  color: themeColor,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              ),
              onPressed: () => changeBackgroundColor(question_testing[2], 3),
              child: Text('${question_testing[2].toUpperCase()}',
                style: TextStyle(
                  fontFamily: "Cooper",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: isAnswerCorrect
                  ? () async {

                setState(() {
                  if(trial == 1) {
                    testing_levels["${widget.current_level}"]++;
                  }
                });

                try {
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(user!.uid)
                      .update(data);
                  print("done");

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Testing_Q3(current_level : widget.current_level),
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

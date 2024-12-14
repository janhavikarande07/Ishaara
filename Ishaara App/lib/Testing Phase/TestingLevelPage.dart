import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shreya/BottomNav.dart';
import '../db_tasks.dart';
import '../values_.dart';
import 'testing_Q1.dart';

import '../Learning Phase/AplhabetsLevelStartPage.dart';
import '../colors.dart';

class TestingPage extends StatefulWidget {
  @override
  State<TestingPage> createState() => TestingPageState();
}

class TestingPageState extends State<TestingPage> {
  final ScrollController _scrollController = ScrollController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Testing Phase',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: "Cooper",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: themeColor,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 3000,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Stack(
                        children: List.generate(30, (index) {
                          bool isUnlocked = index < current_testing_level;
                          bool isCompleted = index < current_testing_level;
                          dynamic stars = testing_levels["${index+1}"];
                          print(stars);
                          return Positioned(
                            bottom: 100 * index.toDouble(),
                            left: (index % 2 == 0) ? 100 : 200,
                            child: Level(level: index + 1,
                              isUnlocked: isUnlocked,
                              isCompleted: isCompleted,
                              stars: (index + 1) == current_testing_level ? null : stars,),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: AssetImage("assets/levels_bg.png"),
                height: 150,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Level extends StatelessWidget {
  final int level;
  final bool isUnlocked;
  final bool isCompleted;
  final dynamic stars;

  Level({
    required this.level,
    required this.isUnlocked,
    required this.isCompleted,
    this.stars,
  });

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> _showMyDialog(context) async {
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
    return GestureDetector(
      onTap: isUnlocked
          ? () {
        print('Tapped on level $level');
        if(lives == 0){
          _showMyDialog(context);
        }
        else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Testing_Q1(current_level: level,),
            ),
          );
        }
      }
          : null,
      child: Column(
        children: [
          if (isCompleted && stars != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildStars(stars is int ? stars.toDouble() : stars),
            ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnlocked ? themeColor : Colors.grey,
              boxShadow: [
                BoxShadow(
                  color: isUnlocked ? themeColor.withOpacity(0.6) : Colors.grey.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$level',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildStars(double rating) {
    List<Widget> starList = [];
    for (int i = 1; i <= 3; i++) {
      if (rating >= i) {
        // Full star
        starList.add(
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 28,
          ),
        );
      } else if (rating >= i - 0.5) {
        // Half star
        starList.add(
          const Icon(
            Icons.star_half,
            color: Colors.amber,
            size: 28,
          ),
        );
      } else {
        // Empty star
        starList.add(
          const Icon(
            Icons.star_border,
            color: Colors.grey,
            size: 28,
          ),
        );
      }
    }
    return starList;
  }
}
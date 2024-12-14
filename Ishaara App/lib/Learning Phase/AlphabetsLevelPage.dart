import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shreya/BottomNav.dart';
import 'package:shreya/values_.dart';
import 'AplhabetsLevelStartPage.dart';
import '../colors.dart';

class AlphabetsPage extends StatefulWidget {
  @override
  State<AlphabetsPage> createState() => AlphabetsPageState();
}

class AlphabetsPageState extends State<AlphabetsPage> {
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
          'Learning Phase',
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
            Text(
              "Alphabets",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Cooper",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                          int currentLevel =
                              current_learning_alphabets_level;
                          bool isUnlocked = index < currentLevel;
                          bool isCompleted = index < currentLevel;
                          // dynamic stars =
                          //     levelData["learning_levels"]?["${index + 1}"] ??
                          //         0.0;

                          return Positioned(
                            bottom: 100 * index.toDouble(),
                            left: (index % 2 == 0) ? 100 : 200,
                            child: Level(
                              level: index + 1,
                              isUnlocked: isUnlocked,
                              isCompleted: isCompleted,
                              // stars: (index + 1) == currentLevel ? null : stars,
                            ),
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
  // final dynamic stars;

  Level({
    required this.level,
    required this.isUnlocked,
    required this.isCompleted,
    // this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUnlocked
          ? () {
        print('Tapped on level $level');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AlphabetsLevelStartPage(current_level: level,),
          ),
        );
      }
          : null,
      child: Column(
        children: [
          // if (isCompleted && stars != null)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: buildStars(stars is int ? stars.toDouble() : stars),
          //   ),
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
    for (int i = 1; i <= 2; i++) {
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
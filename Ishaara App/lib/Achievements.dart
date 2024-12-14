import 'package:flutter/material.dart';
import 'package:shreya/values_.dart';

import 'colors.dart';

class Achievements extends StatefulWidget {
  @override
  State<Achievements> createState() => AchievementsState();
}

class AchievementsState extends State<Achievements> {

  final List<Map<String, dynamic>> achievementData = [
    {
      'image': "assets/fire_achievements.png",
      'name': "Wildfire",
      'finalValue': 15,
      'scoreValue': current_learning_digits_level,
      'description': "Learn all the digits",
      'color': lightThemeColor,
    },
    {
      'image': "assets/sunflower_icon.png",
      'name': "Sage",
      'finalValue': 1000,
      'scoreValue': xp,
      'description': "Earn 1000 XP",
      'color': Color(0x59CE9C9C),
    },
    {
      'image': "assets/scholar_icon.png",
      'name': "Scholar",
      'finalValue': 30,
      'scoreValue': current_learning_alphabets_level,
      'description': "Learn all the alphabets",
      'color': Color(0x8492DEEE),
    },
    {
      'image': "assets/consistent_icon.png",
      'name': "Consistent",
      'finalValue': 5,
      'scoreValue': daily_streak,
      'description': "Streak of 5",
      'color': Color(0x4FD2A5EC),
    },
    {
      'image': "assets/intelligent_icon.png",
      'name': "Intelligent",
      'finalValue': 15,
      'scoreValue': current_testing_level,
      'description': "Complete 15 testing levels",
      'color': Color(0x7CD7D4D4),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Achievements",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: "Cooper",
              ),
            ),
            SizedBox(width: 10),
            Image.asset(
              "assets/honey_jar.png",
              width: 30,
              height: 30,
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Column(
                children: achievementData.map((achievement) {
                  return AchievementTile(
                    image: achievement['image'],
                    name: achievement['name'],
                    finalValue: achievement['finalValue'],
                    scoreValue: achievement['scoreValue'],
                    description: achievement['description'],
                    color: achievement['color'],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AchievementTile extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final Color color;
  final int finalValue;
  final int scoreValue;

  AchievementTile({
    required this.image,
    required this.name,
    required this.description,
    required this.finalValue,
    required this.scoreValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xB6FFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color, // Set the background color
              shape: BoxShape.circle, // Make the shape a circle
              border: Border.all(
                color: Colors.white, // Set the border color
                width: 2, // Set the border width
              ),
            ),
            padding: EdgeInsets.all(7),
            child: ClipRRect(
              child: Image.asset(
                image,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Cooper",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "$scoreValue/$finalValue",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Cooper",
                        fontStyle: FontStyle.normal,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Stack(
                  children: [
                    Container(
                      width: 240,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFCFE2F3),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      width: (scoreValue / finalValue) * 240 ,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: themeColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Cooper",
                    fontStyle: FontStyle.normal,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shreya/db_tasks.dart';
import 'package:shreya/values_.dart';
import 'BottomNav.dart';
import 'get_started.dart';
import 'firebase_options.dart';
import 'initialDetails.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ishaara',
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  User? user = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>> getData() async {
    DocumentReference docRef = FirebaseFirestore.instance.collection("Users").doc(user?.uid);
    DocumentSnapshot snapshot = await docRef.get();
    return snapshot.data() as Map<String, dynamic>;
  }

  @override
  void initState() {
    super.initState();

    // FirebaseAuth.instance.signOut();

    Timer(const Duration(seconds: 2),
      () async {
        if(user == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
              (context) =>  getStartedPage()
              //     (context) => initialDetailsPage()
              )
          );
        }
        else{
          try {
            Map<String, dynamic> data = await getData();

            if(data["day"] != null) {
              if (data["day"] > DateTime.now().day && data["month"] >= DateTime.now().month) {
                await updateUser(user?.uid, {'day': DateTime.now().day, 'month': DateTime.now().month, "lives": 5, "daily_streak": daily_streak++});
              }
            }

            daily_goal = data["daily_goal"] ?? daily_goal;
            daily_streak = data["daily_streak"] ?? daily_streak;
            xp = data["xp"] ?? xp;
            current_learning_alphabets_level = data["current_learning_alphabets_level"] ?? current_learning_alphabets_level;
            current_learning_digits_level = data["current_learning_digits_level"] ?? current_learning_digits_level;
            current_testing_level = data["current_testing_level"] ?? current_testing_level;
            learning_alphabets_levels = data["learning_alphabets_levels"] ?? learning_alphabets_levels;
            learning_digits_levels = data["learning_digits_levels"] ?? learning_digits_levels;
            testing_levels = data["testing_levels"] ?? testing_levels;
            access_testing = data["access_testing"] ?? access_testing;
            lives = data["lives"] ?? lives;
            day = data["day"] ?? DateTime.now().day;
            month = data["month"] ?? DateTime.now().month;

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => HomePage()
                )
            );
          }
          on Exception catch (e) {
            print(e);
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>  getStartedPage()
                )
            );
          }
        }
      }
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child : Center(
          child: Image.asset(
            "assets/ishaara_landing_animation.gif"
          )
        ),
      ),
    );
  }
}

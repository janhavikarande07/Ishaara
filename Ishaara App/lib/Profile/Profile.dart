import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shreya/get_started.dart';
import 'package:shreya/values_.dart';

import '../Authentication/login_screen.dart';

import 'About_US.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors.dart';
import 'Contact_us.dart';
import 'ProfileMenuWidget.dart';
import 'UpdateProfile.dart';

class Profile extends StatefulWidget{

  @override
  State<Profile> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  List data = [];

  Future<List> getData() async {
    DocumentReference docRef = FirebaseFirestore.instance.collection("Users").doc(user?.uid);
    DocumentSnapshot snapshot = await docRef.get();
    Object? fieldValue = snapshot.data();
    data.add(fieldValue);
    print("s $data");
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24), textAlign: TextAlign.center,),
        centerTitle: true,
        backgroundColor: darkThemeColor,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            Map<String, dynamic> data = snapshot.data![0];
            print("data : $data");
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(70),
                          bottomLeft: Radius.circular(70),
                        ),
                        color: darkThemeColor,
                        border: Border.all(
                          width: 3,
                          color: darkThemeColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      padding: const EdgeInsets.all(30),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Color(0x9DFFFFFF),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                padding: EdgeInsets.all(20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "assets/bee.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data["name"] ?? "User",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateProfileScreen(profileData: data,),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: yellowishOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 50),
                              shadowColor: yellowishOrange,
                              elevation: 5,
                            ),
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Cooper",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          // const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
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
                                    // await Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => AlphabetsPage(),
                                    //   ),
                                    // );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: themeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    minimumSize: const Size(120, 100),
                                    // textStyle: TextStyle(fontSize: 14),
                                    shadowColor: yellowishOrange,
                                    elevation: 5,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Image.asset(
                                            "assets/fire_icon.png", width: 30,
                                            height: 30,),
                                          Text(
                                            "$daily_streak",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontFamily: "Cooper",
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "day streak",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: "Cooper",
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // await Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => OTPVerification(mobileNumber: '1234567890',),
                                    //   ),
                                    // );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: themeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    minimumSize: const Size(120, 100),
                                    // textStyle: TextStyle(fontSize: 14),
                                    shadowColor: yellowishOrange,
                                    elevation: 5,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Image.asset(
                                            "assets/bolt_icon.png", width: 30,
                                            height: 30,),
                                          Text(
                                            "$xp",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontFamily: "Cooper",
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "XP earned",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: "Cooper",
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              color: Colors.white,
                              child: Text(
                                'Statistics',
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
                    SizedBox(height: 20,),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 30),
                      child:
                      ProfileMenuWidget(
                          title: "About Us", icon: Icons.info,
                          onPress: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AboutUsScreen(),
                              ),
                            );
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 30),
                      child:
                      ProfileMenuWidget(
                          title: "Contact Us",
                          icon: Icons.perm_contact_cal,
                          onPress: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ContactUsScreen(),
                              ),
                            );
                          }
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      // decoration: BoxDecoration(
                      //   border: Border.all(width: 2, color: Colors.red),
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child:
                      ProfileMenuWidget(
                          title: "Logout",
                          icon: Icons.logout,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () async {
                            FirebaseAuth.instance.signOut();
                            print('Logged out');
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => getStartedPage(),
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        }
      )
    );
  }
}

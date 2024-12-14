import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors.dart';


class ContactUsScreen extends StatefulWidget{

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final String email = "shreyaupadhyay2007@gmail.com";
  final String phoneNumber = "+919920482272";

  // Function to launch email
  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      print('Could not launch $email: $e');
    }
  }

  // Function to launch phone call
  void _launchPhoneCall(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(phoneLaunchUri);
    } catch (e) {
      print('Could not launch $phoneNumber: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:  Text("Contact Us", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),),
        centerTitle: true,
        backgroundColor: darkThemeColor,
      ),
      body : SingleChildScrollView(
        child : Center(
          child : Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Image.asset("assets/ishaara_landing_animation.gif", height: 200,),
                SizedBox(height: 50,),
                Text("Feel free to reach out if you have any questions or need assistance:",
                  style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                // InkWell(
                //   onTap: () => _launchPhoneCall(phoneNumber),
                //   child: Row(
                //     children: [
                //       Icon(Icons.phone, color: Colors.blue),
                //       SizedBox(width: 10),
                //       Text(
                //         phoneNumber,
                //         style: TextStyle(
                //           fontSize: 18,
                //
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => _launchEmail(email),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: themeColor),
                      SizedBox(width: 10),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
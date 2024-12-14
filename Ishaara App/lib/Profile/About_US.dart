import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shreya/colors.dart';


class AboutUsScreen extends StatefulWidget{

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),),
        centerTitle: true,
        toolbarHeight: 50,
        backgroundColor: darkThemeColor,
      ),
      body : SingleChildScrollView(
        child : Center(
          child : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 70,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child : Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 20,),
                    Image.asset("assets/bee.png", width: 70,),
                    SizedBox(height: 20),
                    Text("Ishaara is a pioneering Indian Sign Language (ISL) learning app designed to bridge the communication gap between the deaf and hearing communities. "
                        "\n\nRooted in the vision of fostering inclusivity and understanding, Ishaara combines advanced technology, gamification, and hand gesture recognition powered by machine learning to make ISL learning engaging and accessible."
                        "\n\nWhether you are a beginner or looking to deepen your skills, our interactive and immersive platform is tailored to empower users to confidently master ISL."
                        "\n\nAt Ishaara, we celebrate communication differences as a vital part of human diversity, encouraging creativity, self-expression, and a deeper connection with the linguistic and cultural heritage of the deaf community."
                        "\n\nJoin us in building a world where communication is a bridge, not a barrier.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Positioned(
                  child: Image.asset(
                    "assets/levels_bg.png",
                    width: MediaQuery.of(context).size.width,
                  ),
                  bottom: 0,
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
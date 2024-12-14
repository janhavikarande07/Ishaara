import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shreya/Explore/ExploreAlphabets_2.dart';

import '../colors.dart';

class ExploreAlphabets_1 extends StatefulWidget {
  final String current_alphabet;
  const ExploreAlphabets_1({Key? key, required this.current_alphabet}) : super(key: key);
  @override
  State<ExploreAlphabets_1> createState() => ExploreAlphabets_1State();
}

class ExploreAlphabets_1State extends State<ExploreAlphabets_1> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body :Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 50),
            Text("Alphabet ${widget.current_alphabet}",
              style: TextStyle(
                fontFamily: "Cooper",
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50,),
            Image.asset(
              "assets/alphabets/${widget.current_alphabet}.png", width: 200, height: 200,
            ),
            SizedBox(height: 50,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 50),
              child :
              Text("Ishaara's AI model will accurately detect your hand signs and provide you with an accuracy count.",
                style: TextStyle(
                  fontFamily: "Cooper",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black,

                ),
                textAlign: TextAlign.center,

              ),
            ),
            SizedBox(height: 100,),
            ElevatedButton.icon(onPressed: () async{
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExploreAlphabets_2(current_alphabet : widget.current_alphabet),
                ),
              );
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                minimumSize: const Size(double.infinity, 50),
                // textStyle: TextStyle(fontSize: 14),
                shadowColor: yellowishOrange,
                elevation: 5,
              ),
              icon : const Icon(Icons.camera_alt_outlined, size: 30, color: Colors.black,),
              label: const Text("Start Camera",
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AlphabetsLevelPage.dart';
import 'DigitsLevelPage.dart';
import 'a_Q3_2.dart';

import '../colors.dart';
import 'd_Q3_2.dart';

class D_Q3_1 extends StatefulWidget {
  final String current_digit;
  final int current_level;
  const D_Q3_1({Key? key, required this.current_digit, required this.current_level}) : super(key: key);
  @override
  State<D_Q3_1> createState() => D_Q3_1State();
}

class D_Q3_1State extends State<D_Q3_1> {
  double _width = 0.66 * 300;
  double percent = 1;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _width = percent * 300;
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
              children: [
                IconButton(onPressed: ()async {
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DigitsPage(),
                    ),
                  );
                },
                  icon: Icon(Icons.close, size: 30, weight: 50,),
                ),
                Stack(
                  children: [
                    Container(
                      width: 300,
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
              ],
            ),
            SizedBox(height: 50),
            Text("Number ${widget.current_digit}",
              style: TextStyle(
                fontFamily: "Cooper",
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50,),
            Image.asset(
                "assets/digits/${widget.current_digit}.png", width: 200, height: 200,
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
                  builder: (context) => D_Q3_2(current_digit : widget.current_digit, current_level : widget.current_level),
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
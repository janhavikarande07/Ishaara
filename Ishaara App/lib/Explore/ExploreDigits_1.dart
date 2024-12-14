import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import 'ExploreDigits_2.dart';

class ExploreDigits_1 extends StatefulWidget {
  final String current_digit;
  const ExploreDigits_1({Key? key, required this.current_digit}) : super(key: key);
  @override
  State<ExploreDigits_1> createState() => ExploreDigits_1State();
}

class ExploreDigits_1State extends State<ExploreDigits_1> {
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
                  builder: (context) => ExploreDigits_2(current_digit : widget.current_digit),
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
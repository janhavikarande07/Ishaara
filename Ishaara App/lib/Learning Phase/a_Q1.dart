import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../values_.dart';
import 'AlphabetsLevelPage.dart';
import 'a_Q2.dart';
import '../colors.dart';

class A_Q1 extends StatefulWidget {
  final String current_alphabet;
  final int current_level;
  const A_Q1({Key? key, required this.current_alphabet, required this.current_level}) : super(key: key);

  @override
  State<A_Q1> createState() => A_Q1State();
}

class A_Q1State extends State<A_Q1> {
  double _width = 0;
  double percent = 0.33;

  List<String> question_alphabets = [];
  List<dynamic> buttonStates = [Colors.white, Colors.white, Colors.white, Colors.white];
  bool isAnswerCorrect = false;

  @override
  void initState() {
    super.initState();
    Random random = Random();
    alphabets.shuffle(random);
    alphabets.remove(widget.current_alphabet);
    question_alphabets.add(widget.current_alphabet);
    question_alphabets.add(alphabets[7]);
    question_alphabets.add(alphabets[21]);
    question_alphabets.add(alphabets[13]);
    question_alphabets.shuffle(random);
  }

  void changeBackgroundColor(String answer, int no) {
    setState(() {
      if (answer == widget.current_alphabet) {
        for (int i = 0; i < 4; i++) {
          if ((i + 1) == no) {
            buttonStates[i] = themeColor;
          } else {
            buttonStates[i] = Colors.white;
          }
        }
        isAnswerCorrect = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Correct Answer!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        for (int i = 0; i < 4; i++) {
          if (i + 1 == no) {
            buttonStates[i] = Colors.red;
          } else {
            buttonStates[i] = Colors.white;
          }
        }
        isAnswerCorrect = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect Answer!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _width = percent * 300;
      });
    });

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AlphabetsPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.close, size: 30, weight: 50),
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
                            color: themeColor)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Text(
              "What sign represents Alphabet ${widget.current_alphabet.toUpperCase()}? ",
              style: TextStyle(
                fontFamily: "Cooper",
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    changeBackgroundColor(question_alphabets[0], 1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: buttonStates[0],
                      border: Border.all(
                        color: themeColor,
                        width: 2.0,
                      ),
                    ),
                    child: Image.asset(
                      'assets/alphabets/${question_alphabets[0]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    changeBackgroundColor(question_alphabets[1], 2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: buttonStates[1],
                      border: Border.all(
                        color: themeColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/alphabets/${question_alphabets[1]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    changeBackgroundColor(question_alphabets[2], 3);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: buttonStates[2],
                      border: Border.all(
                        color: themeColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/alphabets/${question_alphabets[2]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    changeBackgroundColor(question_alphabets[3], 4);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: buttonStates[3],
                      border: Border.all(
                        color: themeColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/alphabets/${question_alphabets[3]}.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed:  () async {
                if(isAnswerCorrect) {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          A_Q2(current_alphabet: widget.current_alphabet,
                              current_level: widget.current_level),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isAnswerCorrect ? themeColor : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                minimumSize: const Size(double.infinity, 50),
                shadowColor: yellowishOrange,
                elevation: 5,
              ),
              child: const Text(
                "Continue",
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




// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shreya/initialDetails.dart';
// import 'a_Q2.dart';
// import 'colors.dart';
//
// class A_Q1 extends StatefulWidget {
//   final String current_alphabet;
//   const A_Q1({Key? key, required this.current_alphabet}) : super(key: key);
//   @override
//   State<A_Q1> createState() => A_Q1State();
// }
//
// class A_Q1State extends State<A_Q1> {
//   double _width = 0;
//   double percent = 0.33;
//   Color _buttonColor1 = Colors.white;
//   Color _buttonColor2 = Colors.white;
//   Color _buttonColor3 = Colors.white;
//   Color _buttonColor4 = Colors.white;
//
//   List<String> alphabets = [
//     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
//   ];
//
//   List<String> question_alphabets = [];
//
//   List<dynamic> buttonStates = [Colors.white,Colors.white, Colors.white, Colors.white];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     Random random = Random();
//     alphabets.shuffle(random);
//     alphabets.remove(widget.current_alphabet);
//     question_alphabets.add(widget.current_alphabet);
//     question_alphabets.add(alphabets[7]);
//     question_alphabets.add(alphabets[21]);
//     question_alphabets.add(alphabets[13]);
//     question_alphabets.shuffle(random);
//   }
//
//   void changeBackgroundColor(String answer, int no) {
//     setState(() {
//       if (answer == widget.current_alphabet) {
//         for(int i=0; i<4; i++){
//           if ((i + 1) == no){
//             buttonStates[i] = themeColor;
//           }
//           else{
//             buttonStates[i] = Colors.white;
//           }
//         }
//       } else {
//         for(int i=0; i<4; i++){
//           if (i+1==no){
//             buttonStates[i] = Colors.red;
//           }
//           else{
//             buttonStates[i] = Colors.white;
//           }
//         }
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         _width = percent * 300;
//       });
//     });
//
//     return Scaffold(
//       body :Container(
//         padding: EdgeInsets.all(20.0),
//         alignment: Alignment.center,
//         child: Column(
//           children: [
//             SizedBox(height : 20),
//             Row(
//               children: [
//                 IconButton(onPressed: (){},
//                   icon: Icon(Icons.close, size: 30, weight: 50,),
//                 ),
//                 Stack(
//                   children: [
//                     Container(
//                       width: 300,
//                       height: 20,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: Color(0xFFCFE2F3)),
//                     ),
//                     AnimatedContainer(
//                         duration: const Duration(milliseconds: 800),
//                         width: _width,
//                         height: 20,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: themeColor)
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 50),
//             Text("What sign represents Alphabet ${widget.current_alphabet.toUpperCase()}? ",
//               style: TextStyle(
//                 fontFamily: "Cooper",
//                 fontWeight: FontWeight.w700,
//                 fontSize: 24,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 50,),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 GestureDetector(
//                   onTap: () {changeBackgroundColor(question_alphabets[0], 1);},
//                   child: Container(
//                     padding: EdgeInsets.all(12),
//
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: buttonStates[0],
//                       border: Border.all(
//                         color: themeColor,
//                         width: 2.0,
//                       ),
//                     ),
//                     child: Image.asset(
//                       'assets/alphabets/${question_alphabets[0]}.png',
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 30),
//                 GestureDetector(
//                   onTap: () {changeBackgroundColor(question_alphabets[1], 2);},
//                   child: Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: buttonStates[1],
//                       border: Border.all(
//                         color: themeColor,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Image.asset(
//                       'assets/alphabets/${question_alphabets[1]}.png',
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 GestureDetector(
//                   onTap:() {changeBackgroundColor(question_alphabets[2], 3);},
//                   child: Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: buttonStates[2],
//                       border: Border.all(
//                         color: themeColor,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Image.asset(
//                       'assets/alphabets/${question_alphabets[2]}.png',
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 30),
//                 GestureDetector(
//                   onTap:() { changeBackgroundColor(question_alphabets[3], 4);},
//                   child: Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: buttonStates[3],
//                       border: Border.all(
//                         color: themeColor,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Image.asset(
//                       'assets/alphabets/${question_alphabets[3]}.png',
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 150,),
//             ElevatedButton(
//               onPressed: () async{
//                 // await Navigator.of(context).push(
//                 //   MaterialPageRoute(
//                 //     builder: (context) => Testing_Q2(),
//                 //   ),
//                 // );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: themeColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 minimumSize: const Size(double.infinity, 50),
//                 // textStyle: TextStyle(fontSize: 14),
//                 shadowColor: yellowishOrange,
//                 elevation: 5,
//               ),
//               child: const Text("Continue",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontFamily: "Cooper",
//                   fontStyle: FontStyle.normal,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'a_Q2.dart';
// import 'colors.dart';
//
// class A_Q1 extends StatefulWidget {
//   final String current_alphabet;
//   const A_Q1({Key? key, required this.current_alphabet}) : super(key: key);
//   @override
//   State<A_Q1> createState() => A_Q1State();
// }
//
// class A_Q1State extends State<A_Q1> {
//   double _width = 0;
//   double percent = 0.33;
//   Color _buttonColor1 = Colors.white;
//   Color _buttonColor2 = Colors.white;
//   Color _buttonColor3 = Colors.white;
//
//   void changeBackgroundColor(String answer, int no) {
//     setState(() {
//       if (answer == 'valid' && no == 1) {
//         _buttonColor1 = themeColor;
//         _buttonColor2 = Colors.white;
//         _buttonColor3 = Colors.white;
//         print("valid");
//       } else if (answer == 'invalid' && no == 2) {
//         _buttonColor1 = Colors.white;
//         _buttonColor2 = Colors.red;
//         _buttonColor3 = Colors.white;
//         print("valid");
//       }
//       else{
//           _buttonColor1 = Colors.white;
//           _buttonColor2 = Colors.white;
//           _buttonColor3 = Colors.red;
//           print("valid");
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         _width = percent * 300;
//       });
//     });
//
//     return Scaffold(
//       body :Container(
//         padding: EdgeInsets.all(20.0),
//         alignment: Alignment.center,
//         child: Column(
//           children: [
//             SizedBox(height : 20),
//             Row(
//               children: [
//                 IconButton(onPressed: (){},
//                   icon: Icon(Icons.close, size: 30, weight: 50,),
//                 ),
//                 Stack(
//                   children: [
//                     Container(
//                       width: 300,
//                       height: 20,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: Color(0xFFCFE2F3)),
//                     ),
//                     AnimatedContainer(
//                         duration: const Duration(milliseconds: 800),
//                         width: _width,
//                         height: 20,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: themeColor)
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 50),
//             Text("What alphabet does this sign represent? ",
//               style: TextStyle(
//                 fontFamily: "Cooper",
//                 fontWeight: FontWeight.w700,
//                 fontSize: 24,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 50,),
//             Image.asset("assets/alphabets/a.png", width: 200, height: 150,),
//             SizedBox(height: 50,),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     backgroundColor: _buttonColor1,
//                     side: BorderSide(
//                       color: themeColor,
//                       width: 2,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
//                   ),
//                   onPressed: () => changeBackgroundColor('valid', 1),
//                   child: Text('A',style: TextStyle(
//                     fontFamily: "Cooper",
//                     fontWeight: FontWeight.w700,
//                     fontSize: 24,
//                     color: Colors.black,
//                   ),
//         textAlign: TextAlign.center,),
//                 ),
//                 SizedBox(width: 30),
//                 OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     backgroundColor: _buttonColor2,
//                     side: BorderSide(
//                       color: themeColor,
//                       width: 2,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
//                   ),
//                   onPressed: () => changeBackgroundColor('invalid', 2),
//                   child: Text('B',
//                     style: TextStyle(
//                       fontFamily: "Cooper",
//                       fontWeight: FontWeight.w700,
//                       fontSize: 24,
//                       color: Colors.black,
//                     ),
//                     textAlign: TextAlign.center,),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: _buttonColor3,
//                 side: BorderSide(
//                   color: themeColor,
//                   width: 2,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
//               ),
//               onPressed: () => changeBackgroundColor('invalid', 3),
//               child: Text('C',
//                 style: TextStyle(
//                   fontFamily: "Cooper",
//                   fontWeight: FontWeight.w700,
//                   fontSize: 24,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.center,),
//             ),
//             SizedBox(height: 70,),
//             ElevatedButton(
//               onPressed: () async{
//                 await Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => A_Q2(),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: themeColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 minimumSize: const Size(double.infinity, 50),
//                 // textStyle: TextStyle(fontSize: 14),
//                 shadowColor: yellowishOrange,
//                 elevation: 5,
//               ),
//               child: const Text("Continue",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontFamily: "Cooper",
//                   fontStyle: FontStyle.normal,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
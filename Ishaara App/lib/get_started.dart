import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Authentication/login_screen.dart';

import 'Authentication/register_screen.dart';

class getStartedPage extends StatefulWidget {
  const getStartedPage({super.key});

  @override
  State<getStartedPage> createState() => _getStartedPageState();
}

class _getStartedPageState extends State<getStartedPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body : SafeArea(
        child : Container(
          alignment: Alignment.center,
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Image.asset("assets/bee.png", width : 120, height:120),
              SizedBox(height: 20,),
              const Text(
                "ISHAARA",
                style: TextStyle(
                color: themeColor,
                  fontFamily: "Cooper",
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // const Text(
              //   "Some Tagline",
              //   style : TextStyle(
              //     fontFamily: "Cooper",
              //     fontStyle: FontStyle.normal,
              //     color: Colors.black,
              //     fontSize: 20,
              //   ),
              // ),

              const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      // textStyle: TextStyle(fontSize: 14),
                      shadowColor: darkThemeColor,
                      elevation: 5,
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: const Text("GET STARTED",
                    style : TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                        fontFamily: "Cooper",
                        fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w900
                    )),
                  ),
              const SizedBox(height: 25,),
                  OutlinedButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: darkThemeColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      // textStyle: TextStyle(fontSize: 14),
                    ),
                    child: const Text("I ALREADY HAVE AN\n ACCOUNT",
                        style : TextStyle(
                          color: themeColor,
                          fontSize: 21,
                          fontFamily: "Cooper",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w900,
                        ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              const SizedBox(height: 50,),
          ],

          ),
        ),
      ),
    );
  }
}


// class getStartedPage extends StatefulWidget {
//   const getStartedPage({super.key});
//
//   @override
//   State<getStartedPage> createState() => _getStartedPageState();
// }
//
// class _getStartedPageState extends State<getStartedPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Responsive UI Example'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Spacer to push the content to the center
//           Spacer(),
//           // Center text
//           Center(
//             child: Text(
//               'Centered Text',
//               style: TextStyle(fontSize: 24),
//             ),
//           ),
//           // Spacer to push the buttons to the bottom
//           Spacer(),
//           // Button row at the bottom
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Button 1 action
//                   },
//                   child: Text('Button 1'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Button 2 action
//                   },
//                   child: Text('Button 2'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

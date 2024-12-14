import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shreya/db_tasks.dart';
import 'BottomNav.dart';
import 'colors.dart';

class initialDetailsPage extends StatefulWidget{
  @override
  State<initialDetailsPage> createState() => initialDetailsPageState();
}

class initialDetailsPageState extends State<initialDetailsPage> {
  int _currentQuestionIndex = 0;
  double _width = 0;
  double percent = 0.33;
  TextEditingController nameController = TextEditingController();
  Map<String, dynamic> data = {};
  Color buttonColor1 = Color(0xFFFFFF);
  Color buttonColor2 = Color(0xFFFFFF);
  bool flag1 = true;
  bool flag2 = true;
  int selectedGoal = 0;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    print(user);
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < 2) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You have completed all questions!')));
    }
  }

  Widget _buildQuestion() {
    switch (_currentQuestionIndex) {
      case 0:
        percent = 0.33;
        return _buildFirstQuestion();
      case 1:
        percent = 0.66;
        return _buildSecondQuestion();
      case 2:
        percent = 1;
        return _buildThirdQuestion();
      default:
        return Container();
    }
  }

  Widget _buildFirstQuestion() {
    return Padding(
        padding: EdgeInsets.all(20),
        child : Column(
          key: ValueKey<int>(0),
          children: [
            Text('What should we call you?',
              style: TextStyle(
                  color: Colors.black, fontSize: 24, fontFamily: "Cooper", fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(height: 50,),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: ' Name ',
                labelStyle: TextStyle(
                  color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                  fontFamily: "Cooper",
                  fontStyle: FontStyle.normal,
                ),
                prefixIcon: Icon(Icons.person, color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height : 30),
            Text('Choose something fun and \ncreative...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey, fontSize: 16, fontFamily: "Cooper", fontStyle: FontStyle.normal, fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: (){
                _nextQuestion();
                data["name"] = nameController.text;
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
              child: const Text("Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "Cooper",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
    );
  }

  Widget _buildSecondQuestion() {
    return  Padding(
      padding: EdgeInsets.all(20),
      child : Column(
        key: ValueKey<int>(1),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Great! \nNow choose a daily goal',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontFamily: "Cooper", fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 20),
          Image(
            image: AssetImage("assets/activity_ic.png"),
            width: 150,
            height: 150,
          ),
          SizedBox(height: 20,),
          Expanded (
              child : Column(
                children : [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedGoal = (selectedGoal == 10) ? 0 : 10; // Toggle selection
                        data["daily_goal"] = selectedGoal;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (selectedGoal == 10) ? Color(0xFFFFCC00) : Color(0xFFFFFFFF),
                      side: const BorderSide(color: darkThemeColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                    ),
                    child: const Text(
                      "10 min / day",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontFamily: "Cooper",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedGoal = (selectedGoal == 20) ? 0 : 20; // Toggle selection
                        data["daily_goal"] = selectedGoal;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (selectedGoal == 20) ? Color(0xFFFFCC00) : Color(0xFFFFFFFF),
                      side: const BorderSide(color: darkThemeColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                    ),
                    child: const Text(
                      "20 min / day",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontFamily: "Cooper",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: _nextQuestion,
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
            child: const Text("Continue",
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
    );
  }

  Widget _buildThirdQuestion() {
    return Padding(
      padding: EdgeInsets.all(20),
      child : Column(
        key: ValueKey<int>(0),
        children: [
          const SizedBox(height: 20,),
          Image(
            image: AssetImage("assets/bee.png"),
            height: 120,
            width: 120,
          ),
          SizedBox(height: 40,),
          Text('Welcome to Ishaara',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontFamily: "Cooper", fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 20,),
          Text('Dive into the world of Indian Sign Language (ISL) with a fun, interactive twist! Whether you\'re a beginner or looking to sharpen your skills, Ishaara makes learning ISL easy and exciting. Break barriers, build connections, and speak with your hands. Let your fingers do the talking!',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: "Cooper", fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () async{

              await updateUser(user?.uid, data);

              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
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
            child: const Text("Continue",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: "Cooper",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _width = percent * 300;
      });
    });

    // TODO: implement build
    return  Scaffold(
       body : SingleChildScrollView(
         child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height : 20),
                Row(
                  children: [
                    IconButton(onPressed: ()async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.close, size: 30, weight: 50,),
                    ),
                    Expanded(
                      child : Stack(
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
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Expanded(child:
                  Center(
                    child :
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: _buildQuestion(),
                    ),
                  ),
                ),
              ],
            ),
         ),
       ),
    );
  }
}

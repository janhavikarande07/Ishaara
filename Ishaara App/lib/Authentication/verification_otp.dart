import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shreya/db_tasks.dart';
import 'package:shreya/initialDetails.dart';
import '../BottomNav.dart';
import '../values_.dart';
import 'OTPInput.dart';
import '../colors.dart';

class OTPVerification extends StatefulWidget {
  final String verificationId, mobileNumber, type;
  const OTPVerification({Key? key, required this.verificationId, required this.mobileNumber, required this.type}) : super(key: key);
  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  TextEditingController? otpDigit;
  double screenHeight = 0;
  double screenWidth = 0;
  late Timer _timer;
  int startTime = 30;
  bool isBtnDisabled = true;

  @override
  void initState() {
    initialize();
    super.initState();
    startTimer();
    print(widget.verificationId);
  }

  void initialize() {
    otpDigit = TextEditingController();
  }

  void startTimer() {
    startTime = 30;
    isBtnDisabled = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (startTime == 0) {
          _timer.cancel();
          isBtnDisabled = false;
        } else {
          startTime--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void resendOTP() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP sent!')),
    );
    startTimer();
  }

  Future<void> checkIfPhoneNumberExists(String phoneNumber) async {
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('Users');

    try {
      QuerySnapshot querySnapshot = await usersCollection
          .where('mobile_number', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print("exists");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {

        print("Phone number does not exist. Handle accordingly.");
        print("in");
        User? user = FirebaseAuth.instance.currentUser;

        Map<String, dynamic> data = {
          "email" : "", "name" : "", "profile_image" : "", "mobile_number" : widget.mobileNumber,
          "daily_goal" : daily_goal, "current_learning_digits_level" : current_learning_digits_level, "current_learning_alphabets_level" : current_learning_alphabets_level,
          "learning_digits_levels" : learning_digits_levels, "learning_alphabets_levels" : learning_alphabets_levels,
          "current_testing_level" : current_testing_level, "access_testing" : access_testing, "testing_levels": testing_levels,
          "daily_streak" : 0, 'day':DateTime.now().day, 'month':DateTime.now().month, "lives": 5, "xp": xp
        };

        await createUser(user?.uid, data);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => initialDetailsPage()),
        );
      }
    } catch (e) {
      print("An error occurred while checking Firestore: $e");
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyOtp(String smscode) async {
    print(smscode);
    PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: widget.verificationId,
        smsCode: smscode);
    try{
      await _auth.signInWithCredential(credential);
      print(widget.type);
      if(widget.type == "register"){
        print("in");
        User? user = FirebaseAuth.instance.currentUser;

        Map<String, dynamic> data = {
          "email" : "", "name" : "", "profile_image" : "", "mobile_number" : widget.mobileNumber,
          "daily_goal" : daily_goal, "current_learning_digits_level" : current_learning_digits_level, "current_learning_alphabets_level" : current_learning_alphabets_level,
          "learning_digits_levels" : learning_digits_levels, "learning_alphabets_levels" : learning_alphabets_levels,
          "current_testing_level" : current_testing_level, "access_testing" : access_testing, "testing_levels": testing_levels,
          "daily_streak" : 0, 'day':DateTime.now().day, 'month':DateTime.now().month, "lives": 5, "xp": xp
        };

        await createUser(user?.uid, data);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => initialDetailsPage()),
        );
      }
      else {
        checkIfPhoneNumberExists(widget.mobileNumber);
      }
    }
    catch(e){
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  const Image(
                    image: AssetImage("assets/bee.png"),
                    width: 100,
                    height: 70,
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "OTP VERIFICATION",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 30, fontFamily: "Cooper", fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Verification code sent to ",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "Cooper", fontWeight: FontWeight.normal),
                      ),
                      Text(
                        widget.mobileNumber.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "Cooper", fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  OTPInput(),
                  SizedBox(height: screenHeight * 0.02,),
                  TextButton(
                    onPressed: isBtnDisabled ? null : resendOTP,
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: isBtnDisabled ? Colors.grey : Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                      alignment: Alignment.centerRight,
                    ),
                    child: Text(
                      textAlign: TextAlign.right,
                      isBtnDisabled ? 'Resend ... $startTime secs' : 'Resend OTP',
                      style: TextStyle(
                        color: isBtnDisabled ? Colors.grey : Colors.red,
                      ),
                    ),),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(pinNo);
                      verifyOtp(pinNo);
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
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
  // Widget otpPageHeader() {
  //   return const Text(
  //     StringConstants.verifyAccount,
  //     style: TextStyle(
  //         color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 30),
  //   );
  // }
  // Widget didntReceivedCodeSection() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(
  //         StringConstants.didntReceivedCode,
  //         style: TextStyle(color: Colors.grey, fontSize: 20),
  //       ),
  //       const Text(
  //         StringConstants.resendBtnLabel,
  //         style: const TextStyle(color: Color(0xFFFF5840), fontSize: 20),
  //       ),
  //     ],
  //   );
  // }
  // Widget imageSection() {
  //   return Image.asset(
  //     AssetConstants.appImage,
  //     height: 200,
  //     width: 200,
  //     fit: BoxFit.fill,
  //   );
  // }
  // Widget otpInputSectionText() {
  //   return Text(
  //     StringConstants.sentOtpOn1 +
  //         widget.mobileNumber.toString() +
  //         StringConstants.enterToCompleteVerification,
  //     textAlign: TextAlign.center,
  //     style: const TextStyle(color: Colors.grey, fontSize: 20),
  //   );
  // }

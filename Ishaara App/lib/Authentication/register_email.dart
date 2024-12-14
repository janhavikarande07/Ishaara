import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shreya/db_tasks.dart';
import 'package:shreya/values_.dart';
import 'package:validation_textformfield/validation_textformfield.dart';

import '../colors.dart';
import '../initialDetails.dart';

class emailRegister extends StatefulWidget {
  @override
  State<emailRegister> createState() => _emailRegisterState();
}

class _emailRegisterState extends State<emailRegister> {
  TextEditingController? emailController, passwordController, confirmPasswordController;
  double screenHeight = 0;
  double screenWidth = 0;
  bool isObscure = true;
  bool showvalue = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
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
                    "REGISTER",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 30, fontFamily: "Cooper", fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  EmailValidationTextField(
                    whenTextFieldEmpty: "Please enter  email",
                    validatorMassage: "Please enter valid email",
                    decoration: InputDecoration(
                        labelText: ' Email ',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                          fontFamily: "Cooper",
                          fontStyle: FontStyle.normal,
                        ),
                        prefixIcon: Icon(Icons.email_rounded, color: Colors.black,),
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
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18.0)
                    ),
                    textEditingController: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height : 20),
                  PassWordValidationTextFiled(
                    lineIndicator:false,
                    passwordMinError: "Must be more than 6 charater",
                    hasPasswordEmpty: "Password is Empty",
                    passwordMaxError: "Password too Long",
                    passWordUpperCaseError: "At least one Uppercase(Capital) letter",
                    passWordDigitsCaseError: "At least one digit",
                    passwordLowercaseError: "At least one lowercase character",
                    passWordSpecialCharacters: "At least one Special Characters",
                    obscureText: isObscure,
                    scrollPadding: const EdgeInsets.only(left: 60),
                    // onChanged: (value) {
                    //   // print(value);
                    // },
                    passTextEditingController: passwordController,
                    passwordMaxLength: 12,
                    passwordMinLength: 6,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        labelText: ' Password ',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                          fontFamily: "Cooper",
                          fontStyle: FontStyle.normal,
                        ),
                        prefixIcon: Icon(Icons.password_outlined, color: Colors.black,),
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
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18.0)
                    ),
                  ),
                  const SizedBox(height : 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        value: this.showvalue,
                        checkColor: Colors.white,
                        activeColor: themeColor,
                        onChanged: (bool? value) {
                          setState(() {
                            this.showvalue = value!;
                            isObscure = !value;
                            print(passwordController?.text);
                          });
                        },
                      ),
                      const Text("Show Password",
                        style: TextStyle(
                            color: Color(0xFF2F2F2F),
                            fontSize: 16,
                            fontFamily: "Cooper",
                            fontStyle: FontStyle.normal,
                           ),
                      ),
                    ],
                  ),
                  SizedBox(height : 20),
                  ConfirmPassWordValidationTextFromField(
                    obscureText: isObscure,
                    // obscureText: _isObscure,
                    scrollPadding: EdgeInsets.only(left: 60),
                    // onChanged: (value) {
                    // // print(value);
                    // },
                    whenTextFieldEmpty: "Cannot be Empty",
                    validatorMassage: "Password do not Match",
                    confirmtextEditingController: confirmPasswordController,
                    decoration: const InputDecoration(
                        labelText: ' Confirm Password ',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                          fontFamily: "Cooper",
                          fontStyle: FontStyle.normal,
                        ),
                        prefixIcon: Icon(Icons.password_rounded, color: Colors.black,),
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
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18.0)
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () async{

                      print(emailController!.text);
                      print(passwordController!.text);

                      showDialog(context: context, builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });

                      try {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController!.text,
                          password: passwordController!.text,
                        );

                        User? user = FirebaseAuth.instance.currentUser;

                        Map<String, dynamic> data = {
                          "email" : emailController?.text, "name" : "", "profile_image" : "", "mobile_number" : "",
                          "daily_goal" : daily_goal, "current_learning_digits_level" : current_learning_digits_level, "current_learning_alphabets_level" : current_learning_alphabets_level,
                          "learning_digits_levels" : learning_digits_levels, "learning_alphabets_levels" : learning_alphabets_levels,
                          "current_testing_level" : current_testing_level, "access_testing" : access_testing, "testing_levels": testing_levels,
                          "daily_streak" : 0, 'day':DateTime.now().day, 'month':DateTime.now().month, "lives": 5, "xp": xp
                        };

                        await createUser(user?.uid, data);

                        Navigator.pop(context);

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => initialDetailsPage(),
                          ),
                        );

                      } on FirebaseAuthException catch (e) {
                        Navigator.pop(context);
                        print(e.code);
                      }
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
                    child: const Text("REGISTER",
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
          ),
        ),
      ),
    );
  }
}


import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Home.dart';
import '../BottomNav.dart';
import 'package:validation_textformfield/validation_textformfield.dart';
import 'OTPInput.dart';
import '../colors.dart';

class emailLogin extends StatefulWidget {

  @override
  State<emailLogin> createState() => _emailLoginState();
}

class _emailLoginState extends State<emailLogin> {
  TextEditingController? emailController, passwordController;
  double screenHeight = 0;
  double screenWidth = 0;
  bool isObscure = true;
  bool showvalue = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
                    "LOGIN",
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
                    // textEditingController: emailController,
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
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () async{
                      print(emailController?.text);
                      print(passwordController?.text);

                      showDialog(context: context, builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });

                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController!.text,
                          password: passwordController!.text,
                        );

                        Navigator.pop(context);

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );

                      } on FirebaseAuthException catch (e) {

                        Navigator.pop(context);

                        print(e.code);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Either Username or Password is Incorrect!'),
                            action: SnackBarAction(
                              label: 'Dismiss',
                              onPressed: () {
                                // Code to execute.
                              },
                            ),
                          ),
                        );


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
                    child: const Text("LOGIN",
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


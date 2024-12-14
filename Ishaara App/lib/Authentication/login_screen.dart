import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_email.dart';
import '../colors.dart';
import 'register_screen.dart';
import 'verification_otp.dart';

class LoginPage extends StatefulWidget{

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController numberController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void verifyNumber() async {
    return await _auth.verifyPhoneNumber(
        phoneNumber: "+91${numberController.text}",
        codeSent: (String verificationid, int? resenttoken) async {
          // String smscode= "1234";
          // PhoneAuthCredential credential= PhoneAuthProvider.credential(verificationId: verificationid, smsCode: smscode);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPVerification(
                    verificationId: verificationid,
                    mobileNumber: numberController.text,
                    type: "login"
                  )));
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {
          print(error);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        forceResendingToken: null
    );
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      backgroundColor: const Color(0xffF9F5EB),
      body: SafeArea(
        child : SingleChildScrollView(
        child : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Spacer(),
              SizedBox(height : 20),
              const Text(
                "ISHAARA",
                style: TextStyle(
                  color: themeColor,
                  fontFamily: "Cooper",
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15,),
              // const Text(
              //   "Some Tagline",
              //   style : TextStyle(
              //     fontFamily: "Cooper",
              //     fontStyle: FontStyle.normal,
              //     color: Colors.black,
              //     fontSize: 20,
              //   ),
              // ),
              // const SizedBox(height: 15,),
              const Image(
                image: AssetImage("assets/bee.png"),
                width: 100,
                height: 70,
              ),
              const SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(100),
                    topLeft: Radius.circular(100),
                  ),
                  color: darkThemeColor,
                  border: Border.all(
                    width: 3,
                    color: darkThemeColor,
                    style: BorderStyle.solid,
                  ),
                ),
                padding: const EdgeInsets.all(30),
                child : Column(
                  children: [
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Cooper",
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 50,),
                    TextFormField(
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: const InputDecoration(
                        labelText: ' Phone Number ',
                        labelStyle: TextStyle(
                          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                          fontFamily: "Cooper",
                          fontStyle: FontStyle.normal,
                        ),
                        prefixIcon: Icon(Icons.phone, color: Colors.black,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      "We will send a verification code on your phone number...",
                    style: TextStyle(
                      fontFamily: "Cooper",
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: verifyNumber,
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
                    const SizedBox(height: 10,),
                    const Row(
                      children: <Widget>[
                        Flexible(
                          child: Divider(
                            color: Colors.white,
                            height: 20,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Or",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Cooper",
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Divider(
                            color: Colors.white,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton.icon(onPressed: () async{
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => emailLogin(),
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
                      icon : const Icon(Icons.email_rounded, size: 30, color: Colors.black,),
                      label: const Text("Continue with Email",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: "Cooper",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                InkWell(
                  onTap: () async{
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child:
                    const Text("Create an account...",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontFamily: "Cooper",
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.underline,
                    ),
                    ),
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
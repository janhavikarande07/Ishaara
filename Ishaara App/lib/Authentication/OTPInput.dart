import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:pinput/pinput.dart';
String pinNo = "";
class OTPInput extends StatefulWidget {

  const OTPInput({Key? key}) : super(key: key);
  @override
  State<OTPInput> createState() => _OTPInputState();
}
class _OTPInputState extends State<OTPInput> {

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: themeColor, width: 5),
        borderRadius: BorderRadius.circular(15),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith();
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: themeColor,
      ),
    );
    return Pinput(
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: submittedPinTheme,
      validator: (s) {
        return "";
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) { print(pin);
        pinNo = pin;},
    );
  }
}
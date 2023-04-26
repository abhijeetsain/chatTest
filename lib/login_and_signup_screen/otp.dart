// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print


import 'package:chattingtest/colors.dart';
import 'package:chattingtest/login_and_signup_screen/phonelogin.dart';
import 'package:chattingtest/login_and_signup_screen/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
// import 'package:volunteer_management/screens/login_and_signup_screen/phonelogin.dart';
// import 'package:volunteer_management/screens/login_and_signup_screen/profile.dart';
// import 'package:volunteer_management/utils/colors.dart';

class OtpScreen extends StatefulWidget {

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Image.asset("assets/images/icon.png")),
                    )),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.03),
                      child: Text(
                        "Verify your number",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                      ),
                    ),
                    Text(
                      "phone.no",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        " Wrong Number?",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: OTPTextField(
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 45,
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 15,
                        style: TextStyle(fontSize: 17),
                        onCompleted: (pin) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Verification Code"),
                                content: Text('Code entered is $pin'),
                              );
                            },
                          );
                          setState(() {
                            code = pin;
                          });
                        },
                      ),
                    ),
                    Text(
                      "Enter 6 digit otp",
                      style: GoogleFonts.poppins(
                          color: AppColor.textcolor,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Resend SMS",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.underline,
                              color: AppColor.textcolor,
                              fontWeight: FontWeight.w400,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.appPrimaryColor),
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: PhoneLoginScreen.verify,
                        smsCode: code,
                      );
                      await auth.signInWithCredential(credential);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile_Screen(),
                        ),
                      );
                    } catch (e) {
                      print("wrong otp");
                    }
                  },
                  child: Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

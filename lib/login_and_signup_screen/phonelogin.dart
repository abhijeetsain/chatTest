// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:chattingtest/colors.dart';
import 'package:chattingtest/login_and_signup_screen/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:volunteer_management/screens/login_and_signup_screen/otp.dart';
// import 'package:volunteer_management/utils/colors.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  static String verify = "";

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  TextEditingController countrycode = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var phone = "";
  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Image.asset("assets/images/icon.png")),
                  )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03),
                    child: Center(
                      child: Text(
                        "AAP will need to verify your phone number",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Enter Your Number",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: IntlPhoneField(
                      controller: phoneno,
                      validator: (value) {
                        if (value == null) {
                          return "fill the phone no.";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        phone = value.completeNumber.toString();
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Color(0xff0066A4)),
                        ),
                      ),
                      initialCountryCode: 'IN',
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.appPrimaryColor),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (content) {
                              return AlertDialog(
                                title: Text(
                                  "Your Entered the Phone number:",
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                ),
                                content: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        phone,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                            "Is this OK, or would you like to edit the number ?"),
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Edit"),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(content);
                                      log(phone);

                                      await FirebaseAuth.instance
                                          .verifyPhoneNumber(
                                        phoneNumber: phone,
                                        verificationCompleted:
                                            (PhoneAuthCredential credential) {},
                                        verificationFailed:
                                            (FirebaseAuthException e) {},
                                        codeSent: (String verificationId,
                                            int? resendToken) {
                                          PhoneLoginScreen.verify =
                                              verificationId;

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => OtpScreen(),
                                            ),
                                          );
                                        },
                                        codeAutoRetrievalTimeout:
                                            (String verificationId) {},
                                      );
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        "SEND OTP",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

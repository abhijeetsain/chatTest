// ignore_for_file: prefer_const_constructors, annotate_overrides, camel_case_types




// import 'package:volunteer_management/screens/login_and_signup_screen/phonelogin.dart';
import 'package:chattingtest/colors.dart';
import 'package:chattingtest/login_and_signup_screen/phonelogin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:volunteer_management/utils/colors.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key, int? show});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PhoneLoginScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/icon.png"),
            Padding(
              padding: const EdgeInsets.all(25),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  textAlign: TextAlign.center,
                  "Volunteer Management",
                  style: GoogleFonts.poppins(
                      color: AppColor.appPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.height * 0.03),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

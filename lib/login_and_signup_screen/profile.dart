// ignore_for_file: avoid_init_to_null, unused_field, camel_case_types

import 'dart:io';

import 'package:chattingtest/colors.dart';
import 'package:chattingtest/crop_screen.dart';
import 'package:chattingtest/login_and_signup_screen/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:volunteer_management/screens/onboarding_form_filling/referal.dart';
// import 'package:volunteer_management/utils/colors.dart';
// import 'package:volunteer_management/widgets/crop_screen';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? _images = null;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _images = img;
        Navigator.of(context).pop();
      });
    } on PlatformException {
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptionsScreen(
              onTap: _pickImage,
            ),
          );
        },
      ),
    );
  }

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Profile",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Please provide your name and optionally, a profile photo.",
                        style: GoogleFonts.poppins(
                          color: AppColor.textcolor,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.height * 0.018,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _showSelectPhotoOptions(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[350],
                          radius: 70,
                          child: _images == null
                              ? Center(
                                  child: IconButton(
                                    onPressed: () {
                                      _showSelectPhotoOptions(context);
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey[700],
                                      size: 35,
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.file(
                                    _images!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Form(
                        key: formKey,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Name"),
                          controller: name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.appPrimaryColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OtpScreen()),
                    );
                  },
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import "package:chattingtest/login_and_signup_screen/splashscreen.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:get/get_core/src/get_main.dart";
import "package:get/get_navigation/src/root/get_material_app.dart";
import "package:get/get_navigation/src/routes/get_route.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:uuid/uuid.dart";

var uuid = Uuid();

int? isviewd;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isviewed = prefs.getInt('Home');
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get.put(wardInformationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: '/splashScreen', page: () => Splash_Screen(show: isviewd)),
        GetPage(name: '/Home', page: () => Splash_Screen())
      ],
      home: Splash_Screen(
        // show: isviewd,
      ),
    );
  }
}

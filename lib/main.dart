import 'package:firebase/Google_Sign_in_demo.dart';
import 'package:firebase/Otp/SendOtpScreen.dart';
import 'package:firebase/Otp/VerifyOtpScreen.dart';
import 'package:firebase/RegisterScreen.dart';
import 'package:firebase/SigninScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'DataBase/Get_Database.dart';
import 'DataBase/Get_singleUser.dart';
import 'FireStore/HomeScreen.dart';
import 'FireStore/LoginScreen.dart';
import 'FireStore/RegisterScreen.dart';
import 'GetX/View/home_screen.dart';
import 'GetXTask/View/bottom_nav_bar.dart';
import 'GetXTask/View/home_screen.dart';
import 'ImagePicker/image_box.dart';
import 'ImagePicker/image_picker.dart';
import 'Local_DB/local_data_db.dart';
import 'RippleGetX/View/demo_screen.dart';
import 'RippleGetX/View/studen_screen.dart';
import 'Task/BottomNavigationBar.dart';
import 'Task/HomePage.dart';
import 'Task/LoginPage.dart';
import 'demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoLocalDb(),
    );
  }

  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: DemoState(),
  //   );
  // }

  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: box.read("uid") == null
  //         ? LoginPageDemo()
  //         : BottomNavBraDemo(
  //             id: box.read("uid"),
  //           ),
  //   );
  // }

  ///GetStorege
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: box.read("uid") == null
  //         ? LoginScreenDemo()
  //         : HomeScreenDemo(
  //             id: box.read("uid"),
  //           ),
  //   );
  // }

}

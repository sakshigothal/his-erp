import 'dart:convert';
import 'package:erp/ErpTabBar.dart';
import 'package:erp/clientDoesNPage.dart';
import 'package:erp/common/common.dart';
import 'package:erp/loginscreen.dart';
import 'package:erp/models/docmodel.dart';
import 'package:erp/models/notfiModel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:erp/models/sopmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashsceen extends StatefulWidget {
  const Splashsceen({Key? key}) : super(key: key);

  @override
  _SplashsceenState createState() => _SplashsceenState();
}

class _SplashsceenState extends State<Splashsceen> {
  profile_main? profile;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print("from splash screen value of client id " +
          "${prefs.getString("log")}  " +
          "username   " +
          "${prefs.getString("un")}   " +
          "password   " +
          "${prefs.getString("PS")}   ");

      if (prefs.getString("log") == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => ClientDoesNotExit()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => RoastedHome()));
      }

      // if (pref.getString('profile') != null &&
      //     pref.getString('sop') != null &&
      //     pref.getString('docs') != null &&
      //     pref.getString('notif') != null) {
      // print("Data ${pref.getString('profile')}");
      // print("${notdata?.data?[0].nMessage}");
      // profileData =
      //     profile_main.fromJson(jsonDecode(pref.getString('profile')!));
      // sopdata = Sopmodel.fromJson(jsonDecode(pref.getString("sop")!));
      // docdata = Documents.fromJson(jsonDecode(pref.getString("docs")!));
      // notdata =
      //     NotificationModel.fromJson(jsonDecode(pref.getString('notif')!));

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (ctx) => homepage()));
      // } else {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (ctx) => RoastedHome()));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/buildings.json"),
      ),
    );
  }
}

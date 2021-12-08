import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:erp/ErpTabBar.dart';
import 'package:erp/api/APIManager.dart';
import 'package:erp/common/common.dart';
import 'package:erp/loginscreen.dart';
import 'package:erp/models/notfiModel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationModel? not;
  profile_main? profile;
  Map<String, String> parameters={};
  bool isloading=false;
  var data;
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("log");
  }

  setData() {
      loadData().then((value) {
        setState(() {
          data = value;
        });
      });
    }

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 12.0,
    // fontFamily: 'Horizon',
  );
  @override
  void initState() {
    super.initState();
setData();
    profileApiCall();
    not = notdata;
    isloading=true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton(
          child: Image.asset(
            "assets/infoway2.png",
            fit: BoxFit.contain,
            height: 32,
          ),
          itemBuilder: (BuildContext bc) => [
            PopupMenuItem(
              child: Text("Send Request"),
              onTap: () {},
            ),
            PopupMenuItem(
              child: Text("Settings"),
              onTap: () {},
            ),
            PopupMenuItem(
              child: Text("Logout"),
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => RoastedHome()));
              },
            )
          ],
        ),
        // automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 5,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "HIS-ERP",
                    style: TextStyle(color: Color(0XFF06074F)),
                  ),
                  AnimatedTextKit(animatedTexts: [
                    ColorizeAnimatedText(
                      'Premise Owners Dashboard',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>homepage(),),);
                
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blue[900],
              )),

          // NotificationBadge()
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: isloading ==true? Container(
        child: ListView.separated(
          itemCount: int.parse("${not?.docCount}"),
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: ClipOval(
                          child: Image.asset("assets/infoway2.png"),
                        ),
                        backgroundColor: Colors.white,
                        radius: 40,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${notdata?.data?[index].nTitle}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900]),
                              ),
                              Text(
                                "${notdata?.data?[index].nDate}",
                                style: TextStyle(color: Colors.blue[700]),
                              ),
                              Container(
                                child: Text(
                                  "${notdata?.data?[index].nMessage}",
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (contex, index) {
            return Divider(
              thickness: 4,
            );
          },
        ),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }

  Widget NotificationBadge() {
    return Badge(
        position: BadgePosition.topEnd(top: 0, end: 3),
        animationDuration: Duration(milliseconds: 300),
        animationType: BadgeAnimationType.slide,
        badgeContent: Text(
          "${profile?.UnreadNotifications}",
          style: TextStyle(color: Colors.white),
        ),
        child: IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.blue[900],
            ),
            onPressed: () {
              // parameters["clientid"]=data;
                         
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => NotificationPage()));
                  //  notificationApi();
            }));
  }

  notificationApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    parameters = {
      'clientid': 'clientid' == '' ? data :"${prefs.getString("log")}",
      'username': "${prefs.getString("un")}",
      'password': "${prefs.getString("PS")}",
    };
    APIManager().apiRequest(context, API.notification, (response) async {
      if (response != null) {
        NotificationModel resp = response;
        if (resp.isSuccess == 1) {
          profileApiCall();
          notdata = resp;
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("notif", jsonEncode(resp));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => NotificationPage()));
        }
        print("success ${docdata?.data?.length}");
      }
    }, (error) {
      print("error");
    }, parameter: parameters);
  }

  profileApiCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> parameters = {
      'clientid': "${prefs.getString("log")}",
      'username': "${prefs.getString("un")}",
      'password': "${prefs.getString("PS")}",
    };
    print("parameters $parameters");
    APIManager().apiRequest(context, API.profile, (response) async {
      if (response != null) {
        profile_main resp = response;
        if (resp.isSuccess == 1) {
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (BuildContext ctx) => homepage()));
          profileData = resp;
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("profile", jsonEncode(resp));
        }
      }
    }, (error) {
      print("error");
    }, parameter: parameters);
  }
}

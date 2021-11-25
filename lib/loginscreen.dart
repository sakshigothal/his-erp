import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:erp/api/APIManager.dart';
import 'package:erp/common/common.dart';
import 'package:erp/models/loginmodel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:erp/models/sopmodel.dart';
import 'package:erp/webviewex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ErpTabBar.dart';

class RoastedHome extends StatefulWidget {
  @override
  _RoastedHomeState createState() => _RoastedHomeState();
}

class _RoastedHomeState extends State<RoastedHome> {
  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  var saveD;
  var save;
  bool visible = true;
  static const colorizeTextStyle = TextStyle(
    fontSize: 20.0,
    // fontFamily: 'Horizon',
  );
  TextEditingController clinetid = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController psscode = TextEditingController();

  LoginModel? loginData;
  var last_login;
  @override
  void initState() {
    super.initState();
    getLogin();
    savedlogin();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              alignment: Alignment.topCenter,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/his2.png"),
                      ),
                    ),
                  ),
                  AnimatedTextKit(animatedTexts: [
                    ColorizeAnimatedText(
                      'Premise Owners Dashboard',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ClientID",
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xff06074f)),
                          ),
                          TextFormField(
                            controller: clinetid ,
                            decoration: InputDecoration(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Username",
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xff06074f)),
                          ),
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(
                              color: Color(0xff06074f),
                              fontSize: 16.0,
                            ),
                          ),
                          TextFormField(
                            controller: psscode,
                            obscureText: true,
                            decoration: InputDecoration(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MaterialButton(
                              elevation: 12.0,
                              minWidth: size.width * 0.60,
                              height: size.height * 0.05,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26.0)),
                              color: Colors.white,
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("log", clinetid.text);
                                prefs.setString("un", email.text);
                                prefs.setString("PS", psscode.text);
                                getLogin();
                                loginApiCall();
                              },
                              child: Text("LOGIN",
                                  style: GoogleFonts.titilliumWeb(
                                    textStyle: TextStyle(
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff06074f),
                                      letterSpacing: 0.75,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Divider(),
                            Text("Powered by"),
                            // size
                            Container(
                              height: 35,
                              width: 105,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext ctx) =>
                                            WebViewEx(),
                                      ),
                                    );
                                  },
                                  child: Image.asset("assets/logo.png")),
                            ),
                            SizedBox(height: 20),
                            Text("Release 1.3.0")
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginApiCall() {
    Map<String, String> parameters = {
      'clientid': clinetid.text,
      'username': email.text,
      'password': psscode.text,
    };
    print("parameters $parameters");
    APIManager().apiRequest(context, API.login, (response) {
      LoginModel resp = response;

      if (resp.isSuccess == 1) {
        // userSetUp();
        LoginModel llresp = response;
        loginData = llresp;
        print("Alert Dialog response is ${loginData}");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  // context: context,
                  title: Text("${loginData?.message}"),
                  content: Text("Last Login was on ${loginData?.lastLogin}"),
                  actions: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        profileApiCall();
                        sopapi();
                        // docapi();
                        // notificationApi();
                      },
                    )
                  ]);
            });

        print("success ${resp.username}");
      } else if (resp.isSuccess == 0) {
        loginData = resp;
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text("${loginData?.message}"),
                  actions: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ]);
            });
      }
    }, (error) {
      print("error");
    }, parameter: parameters);
  }

  profileApiCall() async {
    Map<String, String> parameters = {
      'clientid': clinetid.text,
      'username': email.text,
      'password': psscode.text,
    };
    print("parameters $parameters");
    APIManager().apiRequest(context, API.profile, (response) async {
      if (response != null) {
        profile_main resp = response;
        if (resp.isSuccess == 1) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => homepage()));
          profileData = resp;
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("profile", jsonEncode(resp));
        }
      }
    }, (error) {
      print("error");
    }, parameter: parameters);
  }

  sopapi() {
    Map<String, String> parameters = {
      'clientid': clinetid.text,
      'username': email.text,
      'password': psscode.text,
    };
    APIManager().apiRequest(context, API.sop, (response) async {
      if (response != null) {
        Sopmodel resps = response;
        if (resps.isSuccess == 1) {
          sopdata = resps;
          print(sopdata);

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("sop", jsonEncode(resps));
        }
      }
    }, (error) {
      print("error");
    }, parameter: parameters);
  }

  // docapi() {
  //   Map<String, String> parameters = {
  //     'clientid': clinetid.text,
  //     'username': email.text,
  //     'password': psscode.text,
  //   };
  //   APIManager().apiRequest(context, API.info, (response) async {
  //     if (response != null) {
  //       Documents resp = response;
  //       if (resp.isSuccess == 1) {
  //         docdata = resp;
  //         SharedPreferences pref = await SharedPreferences.getInstance();
  //         pref.setString("docs", jsonEncode(resp));
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (ctx) => homepage()));
  //       }
  //     }
  //   }, (error) {
  //     print("error");
  //   }, parameter: parameters);
  // }

  savedlogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("log");
    prefs.getString("un");
    prefs.getString("PS");

    print(
        "${prefs.getString("log")} , ${prefs.getString("un")},${prefs.getString("PS")}");
  }

  Future getLogin() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return Alert(context: context, title: "No Internet Connection", buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => RoastedHome()));
          },
        )
      ]).show();
    }
  }
}

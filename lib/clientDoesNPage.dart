import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:erp/Profile/notifications.dart';
import 'package:erp/api/APIManager.dart';
import 'package:erp/common/common.dart';
import 'package:erp/models/docmodel.dart';
import 'package:erp/models/loginmodel.dart';
import 'package:erp/models/notfiModel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:erp/models/sopmodel.dart';
import 'package:erp/webviewex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ErpTabBar.dart';
import 'loginscreen.dart';

class ClientDoesNotExit extends StatefulWidget {
  ClientDoesNotExit({Key? key}) : super(key: key);
  @override
  _ClientDoesNotExitState createState() => _ClientDoesNotExitState();
}

class _ClientDoesNotExitState extends State<ClientDoesNotExit> {
  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  var spdata;
  var gClientID, gUserName, gPassword;
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
    CheckInternet();
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
                            controller: clinetid,
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
                               

                                gClientID = prefs.getString("log");
                                gUserName = prefs.getString("un");
                                gPassword = prefs.getString("PS");

                                CheckInternet();
                                loginApiCall();
                                
                                print("client id is $gClientID");
                                print("logo image is- ${prefs.getString("img")}");
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
                            Text("Release 1.4.0")
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

  loginApiCall() async {
    SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
    Map<String, String> parameters = {
      'clientid': gClientID,
      'username': gUserName,
      'password': gPassword,
    };

    print("parameters $parameters");
    APIManager().apiRequest(context, API.login, (response) {
      LoginModel resp = response;

      if (resp.isSuccess == 1) {
        // userSetUp();

        LoginModel llresp = response;
         
        loginData = llresp;
        print("Alert Dialog response is ${loginData}");
        prefs.setString("img", "${loginData?.logoimage}");
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
                        // sopapi();
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please try again'),
        ),
      );
      print(" LOGIN API ERROR ");
    }, parameter: parameters);
  }

  profileApiCall() async {
    Map<String, String> parameters = {
      'clientid': gClientID,
      'username': gUserName,
      'password': gPassword,
    };
    APIManager().apiRequest(context, API.profile, (response) async {
      if (response != null) {
        profile_main resp = response;
        if (resp.isSuccess == 1 ) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => homepage()));
          profileData = resp;
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("profile", jsonEncode(resp));
        }
      }
    }, (error) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PROFILE API ERROR'),
        ),
      );
      print("PROFILE API ERRPR ");
    }, parameter: parameters);
  }

  // sopapi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Map<String, String> parameters = {
  //     'clientid': "${prefs.getString("log")}",
  //     'username': "${prefs.getString("un")}",
  //     'password': "${prefs.getString("PS")}",
  //   };
  //   APIManager().apiRequest(context, API.sop, (response) async {
  //     if (response != null) {
  //       Sopmodel resps = response;
  //       if (resps.isSuccess == 1) {
  //         sopdata = resps;
  //         print(sopdata);

  //         SharedPreferences pref = await SharedPreferences.getInstance();
  //         pref.setString("sop", jsonEncode(resps));
  //       }
  //     }
  //   }, (error) {
  //     print("error");
  //   }, parameter: parameters);
  // }

  // docapi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Map<String, String> parameters = {
  //     'clientid': "${prefs.getString("log")}",
  //     'username': "${prefs.getString("un")}",
  //     'password': "${prefs.getString("PS")}",
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

  // notificationApi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Map<String, String> parameters = {
  //     'clientid': "${prefs.getString("log")}",
  //     'username': "${prefs.getString("un")}",
  //     'password': "${prefs.getString("PS")}",
  //   };
  //   APIManager().apiRequest(context, API.notification, (response) async {
  //     if (response != null) {
  //       NotificationModel resp = response;
  //       if (resp.isSuccess == 1) {
  //         // profileApiCall();
  //         notdata = resp;
  //         SharedPreferences pref = await SharedPreferences.getInstance();
  //         pref.setString("notif", jsonEncode(resp));
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (ctx) => NotificationPage()));
  //       }
  //       print("success ${docdata?.data?.length}");
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
    gClientID = prefs.getString("log");
    gUserName = prefs.getString("un");
    gPassword = prefs.getString("PS");
    print(
        "check sharedpref values before login pressed -  ${prefs.getString("log")} , ${prefs.getString("un")},${prefs.getString("PS")}");
  }


  Future CheckInternet() async {
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

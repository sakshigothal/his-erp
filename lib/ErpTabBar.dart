import 'dart:convert';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:erp/ERPHome.dart';
import 'package:erp/Profile/notifications.dart';
import 'package:erp/api/APIManager.dart';
import 'package:erp/common/common.dart';
import 'package:erp/document/documentfile.dart';
import 'package:erp/documents.dart';
import 'package:erp/loginscreen.dart';
import 'package:erp/models/docmodel.dart';
import 'package:erp/models/notfiModel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Sop.dart';
import 'package:badges/badges.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  profile_main? profile;
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

    setState(() {
      profile = profileData;
      docapi();
      profileApiCall();
    });
    _tabController = TabController(length: 3, vsync: this);
    print("${profile?.UnreadNotifications}");
  }

  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  // pref.remove("log");
                  // pref.remove("un");
                  // pref.remove("PS");
                  // pref.remove("profile");
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
          actions: [NotificationBadge()],
          backgroundColor: Colors.white,
        ),
        body: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Container(
                height: MediaQuery.of(context).size.height / 4.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.asset(
                              "assets/icon1.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${profile?.oflatNo}",
                          style: TextStyle(
                              fontFamily: 'Gilroy1',
                              fontSize: 32,
                              color: Color(0XFFe08d6b)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${profile?.oownerNam}",
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20,
                              color: Color(0XFF7a7b7f)),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          color: Color(0XFF2d2f2e),
                          height: 25,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${profile?.bbuildNam}",
                                style: TextStyle(
                                    fontFamily: 'Gilroy2',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFFd5ba4e)),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "${profile?.projnam}",
                                style: TextStyle(
                                    fontFamily: 'Gilroy2',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFFd5ba4e)),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(color: Color(0XFF202427)),
              ),
              TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    child: Text("Profile",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                  Tab(
                    child: Text("Statements",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                  Tab(
                    child: Text("Documents",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                ],
              ),
              Expanded(
                child:
                    TabBarView(controller: _tabController, children: <Widget>[
                  HomepageErp(),
                  TableEx(),
                  DownloadFile(),
                ]),
              ),
            ])),
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
              notificationApi();
            }));
  }

  notificationApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> parameters = {
      'clientid': "${prefs.getString("log")}",
      'username': "${prefs.getString("un")}",
      'password': "${prefs.getString("PS")}",
    };
    APIManager().apiRequest(context, API.notification, (response) async {
      if (response != null) {
        NotificationModel resp = response;
        if (resp.isSuccess == 1) {
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

  docapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> parameters = {
      'clientid': "${prefs.getString("log")}",
      'username': "${prefs.getString("un")}",
      'password': "${prefs.getString("PS")}",
    };
    APIManager().apiRequest(context, API.info, (response) async {
      if (response != null) {
        Documents resp = response;
        if (resp.isSuccess == 1) {
          docdata = resp;
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("docs", jsonEncode(resp));
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (ctx) => DownloadFile()));
        }
        print("success ${docdata?.data?.length}");
      }
    }, (error) {
      print("error");
    }, parameter: parameters);
  }

  

}

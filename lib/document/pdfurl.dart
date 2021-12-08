import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:erp/ErpTabBar.dart';
import 'package:erp/Profile/notifications.dart';
import 'package:erp/api/APIManager.dart';
import 'package:erp/common/common.dart';
import 'package:erp/loginscreen.dart';
import 'package:erp/models/docmodel.dart';
import 'package:erp/models/notfiModel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


// void main(){
//   ErrorWidget.builder= (FlutterErrorDetails details)=> Scaffold( body: Center( child:Text("Please download and view")),);
// }

class Pdfurl extends StatefulWidget {
  final documentName;
  const Pdfurl({Key? key,required this.documentName}) : super(key: key);

  @override
  _PdfurlState createState() => _PdfurlState();
}

class _PdfurlState extends State<Pdfurl> {
  Documents? doc;
  var dio = Dio();
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
    // TODO: implement initState
    super.initState();
        doc = docdata;

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
                pref.remove("log");
                pref.remove("un");
                pref.remove("PS");
                pref.remove("profile");

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
                  Padding(
                    padding: const EdgeInsets.only(top: 2,bottom: 2),
                    child: Text(widget.documentName,style: TextStyle(color: Colors.green,fontSize: 11),),
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blue[900],
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SfPdfViewer.network("https://his-erp.com/${common.docLink}",
              onDocumentLoadFailed: (ispdf) {
            // Image.network(Uri.encodeFull("https://his-erp.com/${common.docLink}"));
            showPopUp();
            // WebView(initialUrl: "https://his-erp.com/${common.docLink}",
            // javascriptMode: JavascriptMode.unrestricted,);

            // OpenFile.open("https://his-erp.com/${common.docLink}");
          }),
        ),
      ),
    );
  }

  showPopUp() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Opening new window in default web browser"),
            actions: [
              TextButton(
                  onPressed: () {
                    launch("https://his-erp.com/${common.docLink}");
                    Navigator.pop(context);
                  },
                  child: Text("Ok")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => homepage()));
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }



  docapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> parameters = {
      'clientid': "${prefs.getString("log")}",
      'username': "${prefs.getString("un")}",
      'password': "${prefs.getString("PS")}",
    };
// common.gClientID= prefs.getString("log")!;
//         common.gUserName=prefs.getString("un")!;
//         common.gPassword=prefs.getString("PS")!;

//     Map<String, String> parameters = {
//       'clientid': common.gClientID,
//       'username': common.gPassword,
//       'password': common.gPassword,
//     };



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

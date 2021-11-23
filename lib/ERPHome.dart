import 'dart:convert';

import 'package:erp/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/APIManager.dart';
import 'models/profilemain.dart';

class HomepageErp extends StatefulWidget {
  const HomepageErp({Key? key}) : super(key: key);

  @override
  _HomepageErpState createState() => _HomepageErpState();
}

class _HomepageErpState extends State<HomepageErp> {
  profile_main? profile;
  @override
  void initState() {
    super.initState();
    profileApiCall();
    setState(() {
      profile = profileData;
    });
  }

  String? data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white, body: allwidgets()),
    );
  }

  showcard(String txt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.blue[900]),
        height: 200,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10,right: 15),
              child: Text(
                txt,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onpressButton() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              height: 650,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Carpet Area (SQFT)",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.carpetSqft}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Carpet Area (SQMT)",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.carpetSqmt}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        // begins here
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Agreement",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.tamtpay}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Due Upto Date",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.tamtdue}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Paid Upto Date",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.tamtrec}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Overdue",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.overdue}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              "${profileData?.overdue?.substring(0, 1)}" ==
                                                      "-"
                                                  ? Colors.red
                                                  : Colors.blue[900]),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Final Balance",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.tamtbalance}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              "${profileData?.tamtbalance?.substring(0, 1)}" ==
                                                      "-"
                                                  ? Colors.red
                                                  : Colors.blue[900]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // upto here
                        Divider(
                          thickness: 4,
                        ),

                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Text(
                              "Channel Partner ",
                              style: TextStyle(fontSize: 15),
                            ),
                            trailing: Text("${profileData?.cpname}"),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),

                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "GST % ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.gstpc}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Intrest % ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.intrate}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Divider(
                          thickness: 4,
                        ),

                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Stamp Duty Amount ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "${profileData?.sdamt}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Payment Details",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text("${profileData?.sddet}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Divider(
                          thickness: 4,
                        ),

                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Text(
                              "Registration Amount ",
                              style: TextStyle(fontSize: 15),
                            ),
                            trailing: Text("${profileData?.regamt}"),
                          ),
                        ),

                        Divider(
                          thickness: 4,
                        ),

                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Text(
                              "Advance Maintenance ",
                              style: TextStyle(fontSize: 15),
                            ),
                            trailing: Text("${profileData?.advmaint}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  secondOnpress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              height: 650,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Housing Finance Institution ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Text("${profileData?.LOANBANKN}"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "NOC Date ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                "${profileData?.NOCDATE}" == "00/00/00"
                                    ? Text("N/A")
                                    : Text("${profileData?.NOCDATE}"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Loan Amount ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text("${profileData?.LOANAMT}"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Loan A/C No ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text("${profileData?.LACCOUNTNO}"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Column(
                              children: [
                                Text(
                                  "Contract Person ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Text("${profileData?.CONTACTP}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  thirdOnPress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              height: 650,
// color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Booking Date ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text("${profileData?.obookngDt}"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Allotment Date",
                                  style: TextStyle(fontSize: 15),
                                ),
                                "${profileData?.ALLOT_DT}" == "00/00/00"
                                    ? Text("N/A")
                                    : Text("${profileData?.ALLOT_DT}"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Agreement Date",
                                  style: TextStyle(fontSize: 15),
                                ),
                                "${profileData?.AGREE_DT}" == "00/00/00"
                                    ? Text("N/A")
                                    : Text("${profileData?.AGREE_DT}"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Registration Date",
                                  style: TextStyle(fontSize: 15),
                                ),
                                "${profileData?.REGDT}" == "00/00/00"
                                    ? Text("N/A")
                                    : Text("${profileData?.REGDT}"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Possession Date ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                "${profileData?.POSSESS_DT}" == "00/00/00"
                                    ? Text("N/A")
                                    : Text("${profileData?.POSSESS_DT}"),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            hoverColor: Colors.red,
                            enabled: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "OC Date ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                "${profileData?.OCDATE}" == "00/00/00"
                                    ? Text("N/A")
                                    : Text("${profileData?.OCDATE}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  allwidgets() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blue[900],
                                ),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${profile?.oownerNam}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Gilroy2',
                                        ),
                                      ),
                                      Text("${profile?.oownerN2}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.red[200],
                                            fontFamily: 'Gilroy2',
                                          )),
                                      Text("${profile?.oownerN3}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red[200],
                                            fontFamily: 'Gilroy2',
                                          )),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text("${profile?.oownerCell}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red[200],
                                                fontFamily: 'Gilroy2',
                                              )),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("${profile?.email}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red[200],
                                                fontFamily: 'Gilroy2',
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${profile?.oadd}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red[200],
                                            fontFamily: 'Gilroy2',
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Booking Date ${profile?.obookngDt}",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                70,
                                            color: Colors.white70,
                                            fontFamily: 'Gilroy2',
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            child: Text(
                                              "Profile",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          onpressButton();
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        showcard(
                          "Finance",
                        ),
                      ],
                    ),
                    onTap: () {
                      secondOnpress();
                    },
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        showcard(
                          "MileStones",
                        )
                      ],
                    ),
                    onTap: () {
                      thirdOnPress();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
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

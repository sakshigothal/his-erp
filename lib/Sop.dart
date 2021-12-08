import 'dart:async';
import 'dart:convert';
import 'package:erp/ErpTabBar.dart';
import 'package:erp/api/APIManager.dart';
import 'package:erp/models/docmodel.dart';
import 'package:erp/models/gstmodel.dart';
import 'package:erp/models/sopmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'common/common.dart';
import 'models/profilemain.dart';

class TableEx extends StatefulWidget {
  TableEx({Key? key}) : super(key: key);

  @override
  _TableExState createState() => _TableExState();
}

class _TableExState extends State<TableEx> {
  profile_main? profile;
  Sopmodel? details;
  GSTModel? GSTData;
  List list = [];
  List list2 = [];
  List list3 = [];
  String gstBalance = "";
  bool isonline = false;
  double CumPC = 0.00;
  double sCumPC = 0;
  String PC = '';

  @override
  void initState() {
    super.initState();
    profileApiCall();
    sopapi();
    gstApi();
    setState(() {
      details = sopdata;
      GSTData = gstdata;
    });
    isonline = true;
  }

  String? data;
  callme() async {
    await Future.delayed(Duration(seconds: 2));
    apicall().then((value) => {
          setState(() {
            data = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return isonline == true
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      CumPC = 0;
                    sopdata != null &&  "${sopdata?.dataAgr}" != "null" 
                          ? onepressButton()
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Not Yet Due...",
                                        style: TextStyle(color: Colors.red),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"))
                                    ],
                                  ),
                                );
                              });
                    },
                    child: Column(
                      children: [
                        showcard(
                          "Agreement",
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        showcard(
                          "Other Charges",
                        ),
                      ],
                    ),
                    onTap: () {
                      "${sopdata?.dataOthchg}" != "null" && sopdata != null
                          ? secondPress()
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Not Yet Due...",
                                        style: TextStyle(color: Colors.red),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"))
                                    ],
                                  ),
                                );
                              });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      // gstApi();
                    sopdata != null ?  ThirdOnpress() : Center( child:  CircularProgressIndicator(),);
                    },
                    child: Column(
                      children: [
                        showcard("GST"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                     sopdata != null ? FourthOnpress() : Center(child: CircularProgressIndicator());
                    },
                    child: Column(
                      children: [
                        showcard("TDS"),
                      ],
                    ),
                  ),
                ],
              ),
            ))
        : Center(child: CircularProgressIndicator());
  }

  ThirdOnpress() {
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Due "),
                                    Text("${GSTData?.gstdue}".split(".").first)
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Paid "),
                                    Text("${GSTData?.TGSTAmtRec}")
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Balance "),
                                    Text(
                                      // ""
                                      getGSTbalance(
                                              double.parse(
                                                  "${GSTData?.gstdue}"),
                                              double.parse(
                                                  "${GSTData?.TGSTAmtRec}"))
                                          .toString(),
                                      style: TextStyle(
                                        color: gstBalance.substring(0, 1) != "-"
                                            ? Colors.blue[900]
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                )
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

  FourthOnpress() {
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Due "),
                                    Text("${GSTData?.tdsdue}")
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Paid "),
                                    Text("${GSTData?.tdsrec}")
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Balance "),
                                    Text(
                                      getGSTbalance(
                                              double.parse(
                                                  "${GSTData?.tdsdue}"),
                                              double.parse(
                                                  "${GSTData?.tdsrec}"))
                                          .toString(),
                                      style: TextStyle(
                                        color: gstBalance.substring(0, 1) != "-"
                                            ? Colors.blue[900]
                                            : Colors.red,
                                      ),
                                    )
                                  ],
                                )
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
                padding: const EdgeInsets.all(16),
                child: Text(
                  txt,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              )
            ],
          )),
    );
  }

  onepressButton() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              height: 500,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListView.separated(
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue[900],
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                          "${sopdata?.dataAgr?[index].pdate?.substring(0, 2)}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${sopdata?.dataAgr?[index].mth} '${sopdata?.dataAgr?[index].pdate?.substring(6, 8)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                        // color: Colors.amber,
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${sopdata?.dataAgr?[index].part1}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Row(
                                          children: [
                                            "${sopdata?.dataAgr?[index].amt?.substring(0, 1)}" !=
                                                    "-"
                                                ? Text(
                                                    "${sopdata?.dataAgr?[index].part2} - ",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black))
                                                : Expanded(
                                                    child: Text(
                                                        "${sopdata?.dataAgr?[index].part2}",
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Colors.black)),
                                                  ),
                                            "${sopdata?.dataAgr?[index].amt?.substring(0, 1)}" !=
                                                    "-"
                                                ? Text(
                                                    calculatePer(
                                                                double.parse(
                                                                    "${sopdata?.dataAgr?[index].amt}"),
                                                                double.parse(
                                                                    "${profileData?.tamtpay}"),
                                                                "% - / ")
                                                            .toString() +
                                                        list3[index] +
                                                        "%",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold))
                                                : Text("")
                                            // Text("${list2[index]}")
                                          ],
                                        )
                                      ],
                                    )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${sopdata?.dataAgr?[index].amt}",
                                    style: TextStyle(
                                        color:
                                            "${sopdata?.dataAgr?[index].amt?.substring(0, 1)}" ==
                                                    "-"
                                                ? Colors.red
                                                : Colors.blue[900]),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return Divider(
                            thickness: 4,
                          );
                        },
                        itemCount: int.parse("${sopdata?.agrCount}"),
                      )),
                ),
              ));
        });
  }

  secondPress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              height: 500,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListView.separated(
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue[900],
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                          "${sopdata?.dataOthchg?[index].pdate?.substring(0, 2)}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${sopdata?.dataOthchg?[index].mth} '${sopdata?.dataOthchg?[index].pdate?.substring(6, 8)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                        // color: Colors.amber,
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${sopdata?.dataOthchg?[index].part1}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        Text(
                                            "${sopdata?.dataOthchg?[index].part2}",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.black))
                                      ],
                                    )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${sopdata?.dataOthchg?[index].amt}",
                                    style: TextStyle(
                                        color:
                                            "${sopdata?.dataOthchg?[index].amt?.substring(0, 1)}" ==
                                                    "-"
                                                ? Colors.red
                                                : Colors.blue[900]),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return Divider(
                            thickness: 4,
                          );
                        },
                        itemCount: int.parse("${sopdata?.othchgCount}"),
                      )),
                ),
              ));
        });
  }

  apicall() async {
    Map<String, dynamic> bodyData = {};

    var resp = await http.post(
        Uri.parse("https://his-erp.com/API_CustApp/profile_main.php"),
        body: bodyData);

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("user_post", resp.body);

    if (resp.statusCode == 200) {
      // final jsonResponse = json.decode(resp.body);
      print("Login API");
      // print(jsonResponse);

      setState(() {
        profile = profile_main.fromJson(json.decode(resp.body));
        print(profile?.bbuildNam);
      });
    } else {
      throw Exception('Failed to load login from API');
    }
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
          getdata();
        }
      }
    }, (error) {
      print("error");
    }, parameter: parameters);
  }

  sopapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> parameters = {
      'clientid': "${prefs.getString("log")}",
      'username': "${prefs.getString("un")}",
      'password': "${prefs.getString("PS")}",
    };
    APIManager().apiRequest(context, API.sop, (response) async {
      if (response != null) {
        Sopmodel resps = response;
        if (resps.isSuccess == 1) {
          sopdata = resps;
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("sop", jsonEncode(resps));
          getdata();

          // final vlist = jsonDecode(resps.dataAgr.toString());

          // List vlist = json
          //     .decode(response)['dataAgr']
          //     .map((data) => Sopmodel.fromJson(data))
          //     .toList();
          print("check vlist --->");
          // print(vlist);
        }
      }
    }, (error) {
      print("error");
    }, parameter: parameters);
  }

  calculatePer(double a, double b, String c) {
    double t = ((a / b) * 100);
    String a1 = (t).toStringAsFixed(2) + c;
    CumPC = CumPC + t;
    return a1;
  }

  gstApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> parameters = {
      'clientid': "${prefs.getString("log")}",
      'username': "${prefs.getString("un")}",
      'password': "${prefs.getString("PS")}",
    };
    APIManager().apiRequest(context, API.gst, (response) async {
      if (response != null) {
        GSTModel resps = response;
        if (resps.isSuccess == 1) {
          GSTModel gstresp = response;
          GSTData = gstresp;
          // if (sopdata != null) {
          //   ThirdOnpress();
          // }

          print(gstdata);
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("gst", jsonEncode(resps));
        }
      }
    }, (error) {
      print("error");
    }, parameter: parameters);
  }

  getGSTbalance(double a, double b) {
    gstBalance = (a - b).toStringAsFixed(0);
    return gstBalance;
  }

  getdata() {
    print('entering getdata() method');
    // CumPC = 0;
    for (var i = 0; i < sopdata!.dataAgr!.length; i++) {
      list.add(sopdata!.dataAgr![i].amt);

      if ("${sopdata?.dataAgr?[i].amt?.substring(0, 1)}" != "-") {
        CumPC = (double.parse("${list[i]}") /
            double.parse("${profileData?.tamtpay}") *
            100);

        sCumPC = sCumPC + CumPC;
      }
      list2.add(CumPC);
      list3.add(sCumPC.toStringAsFixed(2));

      // PC = ((double.parse("${list[i]}") /
      //             double.parse("${profileData?.tamtpay}")) *
      //         100)
      //     .toStringAsFixed(2);
      // print('PC is ' + i.toStringAsFixed(0) + ' -->' + PC);

    }
    print("list is $list");
    print(" list2 is $list2");
    print("list3 is $list3");
    // CumPC = CumPC + (double.parse("${list[i]}") /
    //           double.parse("${profileData?.tamtpay}")) *
    //       100;
    // sCumPC = CumPC.toStringAsFixed(2);
    // list2.add(PC + '/ '+ sCumPC);
    // list2.add(PC);
  }
}

  // }


 Widget progressBar(){
return Center(child: CircularProgressIndicator());
}


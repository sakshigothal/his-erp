// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:erp/models/profilemain.dart';
// import 'package:flutter/material.dart';

// class Common extends StatefulWidget {
//   final String clientid;
//   final String username;
//   final String pasword;
//   const Common(
//       {Key? key,
//       required this.clientid,
//       required this.username,
//       required this.pasword})
//       : super(key: key);

//   @override
//   _CommonState createState() => _CommonState();
// }

// class _CommonState extends State<Common> {
//   profile_main? profile;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     apicall();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 290,
//           width: 300,
//           // child: Text("sakshi Gothal"),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             gradient: LinearGradient(colors: [
//               Colors.purple.shade900,
//               Colors.red.shade700,
//             ]),
//           ),
//         ),
//         Container(
//           height: 270,
//           width: 280,
//           color: Colors.white.withOpacity(0.25),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
// // SizedBox(height: MediaQuery.of(context).size.height/4,),
//               Text(
//                 "${profile?.oOWNERNAM}",
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//               Divider(thickness: 3),
//               Text(
//                 "${profile?.bBUILDNAM}",
//                 style: TextStyle(fontSize: 25, color: Colors.white),
//               ),
//               Divider(thickness: 3),
//               Text(
//                 "${profile?.pROJNAM}",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               Divider(thickness: 3),
//               Text(
//                 "${profile?.oFLATNO}",
//                 style: TextStyle(fontSize: 15, color: Colors.white),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   // Text("4545")
//                 ],
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   apicall() async {
//     Map<String, dynamic> bodyData = {
//       'clientid': widget.clientid,
//       'username': widget.username,
//       'password': widget.pasword,
//     };

//     var resp = await http.post(
//         Uri.parse("https://his-erp.com/API_CustApp/profile_main.php"),
//         body: bodyData);

//     if (resp.statusCode == 200) {
//       // final jsonResponse = json.decode(resp.body);
//       print("Login API");
//       // print(jsonResponse);

//       setState(() {
//         profile = profile_main.fromJson(json.decode(resp.body));
//         print(profile!.bBUILDNAM);
//       });
//     } else {
//       throw Exception('Failed to load login from API');
//     }
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:erp/models/profilemain.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Common {
//   profile_main? profile;

//   Widget commoncrad() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 290,
//           width: 300,
//           // child: Text("sakshi Gothal"),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             gradient: LinearGradient(colors: [
//               Colors.purple.shade900,
//               Colors.red.shade700,
//             ]),
//           ),
//         ),
//         Container(
//           height: 270,
//           width: 280,
//           color: Colors.white.withOpacity(0.25),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
// // SizedBox(height: MediaQuery.of(context).size.height/4,),
//               Text(
//                 "${profile?.oOWNERNAM}",
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//               Divider(thickness: 3),
//               Text(
//                 "${profile?.bBUILDNAM}",
//                 style: TextStyle(fontSize: 25, color: Colors.white),
//               ),
//               Divider(thickness: 3),
//               Text(
//                 "${profile?.pROJNAM}",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               Divider(thickness: 3),
//               Text(
//                 "${profile?.oFLATNO}",
//                 style: TextStyle(fontSize: 15, color: Colors.white),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   // Text("4545")
//                 ],
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   apicall() async {
//     Map<String, dynamic> bodyData = {
//       'clientid': widget.clientid,
//       'username': widget.username,
//       'password': widget.pasword,
//     };

//     var resp = await http.post(
//         Uri.parse("https://his-erp.com/API_CustApp/profile_main.php"),
//         body: bodyData);

//     if (resp.statusCode == 200) {
//       // final jsonResponse = json.decode(resp.body);
//       print("Login API");
//       // print(jsonResponse);

//       setState(() {
//         profile = profile_main.fromJson(json.decode(resp.body));
//         print(profile!.bBUILDNAM);
//       });
//     } else {
//       throw Exception('Failed to load login from API');
//     }
//   }
// }

import 'package:erp/models/docmodel.dart';
import 'package:erp/models/notfiModel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:erp/models/sopmodel.dart';

profile_main? profileData;
Sopmodel? sopdata;
Documents? docdata;
NotificationModel? notdata;


class common {
  static var docLink = "";
}




// import 'dart:convert';

// import 'package:erp/common/common.dart';
// import 'package:erp/models/docmodel.dart';
// import 'package:erp/models/profilemain.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:url_launcher/link.dart';
// // import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/link.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';

// import 'pdfurl.dart';

// class Documentsex extends StatefulWidget {
//   const Documentsex({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _DocumentsexState createState() => _DocumentsexState();
// }

// class _DocumentsexState extends State<Documentsex> {
//   // List<Document> pdf = [];
//   profile_main? profile;
//   Documents? doc;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // apicall();
//     doc = docdata;

//     profile = profileData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: commonc(),
//                 // ),
//                 ListView.builder(
//                     itemCount: int.parse("${doc?.docCount}"),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Material(
//                           child: ListTile(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0)),
//                             selected: true,
//                             selectedTileColor: Colors.grey[300],
//                             hoverColor: Colors.red,
//                             enabled: true,
//                             onTap: () async {
//                               // if (await canLaunch(
//                               //     "https://his-erp.com/${doc?.data?[index].docLink}")) {
//                               //   await launch(
//                               //     "https://his-erp.com/${doc?.data?[index].docLink}",
//                               //     forceWebView: true,
//                               //     enableJavaScript: true,
//                               //   );
//                               // }
//                               common.docLink = "${doc?.data?[index].docLink}";
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (ctx) => Pdfurl()));
//                             },
//                             title: Text("${doc?.data?[index].docName}"),
//                           ),
//                         ),
//                       );
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// //   callApi() async {
// //     var response = await http.post(
// //       Uri.parse("https://his-erp.com/API_CustApp/DocumentQuery.php"),
// //     );
// //     print("Resp --> ${response.body}");
// //     setState(() {
// //       doc = Documents.fromJson(jsonDecode(response.body));
// //     });
// //   }
// }

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:permission_handler/permission_handler.dart';

import 'package:erp/common/common.dart';
import 'package:erp/models/docmodel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/link.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:android_path_provider/android_path_provider.dart';

import 'pdfurl.dart';

class Documentsex extends StatefulWidget {
  const Documentsex({
    Key? key,
  }) : super(key: key);

  @override
  _DocumentsexState createState() => _DocumentsexState();
}

class _DocumentsexState extends State<Documentsex> {
  // List<Document> pdf = [];
  profile_main? profile;
  Documents? doc;
  late String _localPath;
  @override
  void initState() {
    super.initState();
    // apicall();
    FlutterDownloader.registerCallback(downloadCallback);
    doc = docdata;
    profile = profileData;
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ListView.builder(
                    itemCount: int.parse("${doc?.docCount}"),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              selected: true,
                              selectedTileColor: Colors.grey[300],
                              hoverColor: Colors.red,
                              enabled: true,
                              onTap: () async {
                                // if (await canLaunch(
                                //     "https://his-erp.com/${doc?.data?[index].docLink}")) {
                                //   await launch(
                                //     "https://his-erp.com/${doc?.data?[index].docLink}",
                                //     forceWebView: true,
                                //     enableJavaScript: true,
                                //   );
                                // }
                                common.docLink = "${doc?.data?[index].docLink}";
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => Pdfurl()));
                              },
                              title: Text("${doc?.data?[index].docName}"),
                              trailing: IconButton(
                                onPressed: () async {
                                  final status =
                                      await Permission.storage.request();

                                  // final externalDir =
                                  //     await getExternalStorageDirectory();

                                  var downloadpath = await localPath();
                                  await _prepareSaveDir();
                                  final taskId =
                                      await FlutterDownloader.enqueue(
                                    url:
                                        // "https://www.vancouvertrails.com/blog/wp-content/uploads/2019/10/1-z.jpg"
                                        "https://his-erp.com/${common.docLink}",
                                    savedDir: downloadpath,
                                    fileName: "abc",
                                    showNotification:
                                        true, // show download progress in status bar (for Android)
                                    openFileFromNotification:
                                        true, // click on notification to open downloaded file (for Android)
                                  );
                                },
                                icon: Icon(Icons.download),
                              ),
                            ),
                          ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> localPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    var _localPath = directory!.path + Platform.pathSeparator + 'Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    return _localPath;
  }

//   callApi() async {
//     var response = await http.post(
//       Uri.parse("https://his-erp.com/API_CustApp/DocumentQuery.php"),
//     );
//     print("Resp --> ${response.body}");
//     setState(() {
//       doc = Documents.fromJson(jsonDecode(response.body));
//     });
//   }
}

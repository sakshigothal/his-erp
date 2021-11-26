import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:erp/api/APIManager.dart';
import 'package:erp/common/common.dart';
import 'package:erp/document/pdfurl.dart';
import 'package:erp/models/docmodel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:isolate';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadFile extends StatefulWidget {
  const DownloadFile({Key? key}) : super(key: key);

  @override
  _DownloadFileState createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  late String _localPath;
  Documents? doc;
  profile_main? profile;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(downloadCallback);
    doc = docdata;
    docapi();
    profile = profileData;
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  Future<bool> _checkPermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Theme.of(context).platform == TargetPlatform.android &&
        androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Column(children: [
              ListView.builder(
                  itemCount: int.parse("${doc?.docCount}"),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 4, top: 4),
                        child: Material(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.blue[900],
                            hoverColor: Colors.red,
                            enabled: true,
                            onTap: () async {
                              common.docLink = "${doc?.data?[index].docLink}";
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => Pdfurl()));
                            },
                            title: Text(
                              "${doc?.data?[index].docName}",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                var tempDir = await getTemporaryDirectory();
                                _localPath = tempDir.path;

                                var path =
                                    "https://his-erp.com/${common.docLink}";
                                var arr = path.split(".");
                                var outputPath =
                                    "$_localPath/${doc?.data?[index].docName}.${arr.last}";

                                try {
                                  var respp =
                                      await dio.download(path, outputPath);
                                  print("Status Code ${respp.statusCode}");
                                  if (respp.statusCode == 200) {
                                    final _result =
                                        await OpenFile.open(outputPath);
                                    print(_result.message);
                                  } else {
                                    print("Error opening file");
                                  }
                                } catch (e) {
                                  print("Exception $e");
                                }
                              },
                              icon: Icon(Icons.download, color: Colors.white),
                            ),
                          ),
                        ));
                  }),
            ])));
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

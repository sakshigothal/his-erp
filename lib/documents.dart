import 'package:erp/common/common.dart';
import 'package:erp/models/docmodel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'pdfurl.dart';

class Documentsex extends StatefulWidget {
  const Documentsex({
    Key? key,
  }) : super(key: key);

  @override
  _DocumentsexState createState() => _DocumentsexState();
}

class _DocumentsexState extends State<Documentsex> {
  profile_main? profile;
  Documents? doc;
  @override
  void initState() {
    super.initState();
    doc = docdata;
    profile = profileData;
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
                              common.docLink = "${doc?.data?[index].docLink}";
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => Pdfurl()));
                            },
                            title: Text("${doc?.data?[index].docName}"),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


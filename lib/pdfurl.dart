import 'package:erp/common/common.dart';
import 'package:erp/models/docmodel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfurl extends StatefulWidget {
  const Pdfurl({Key? key}) : super(key: key);

  @override
  _PdfurlState createState() => _PdfurlState();
}

class _PdfurlState extends State<Pdfurl> {
  Documents? doc;
  @override
  void initState() {
    super.initState();
    doc = docdata;
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: SfPdfViewer.network("https://his-erp.com/${common.docLink}")),
    );
  }
}

import 'package:erp/common/common.dart';
import 'package:erp/models/docmodel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Pdfurl extends StatefulWidget {
  const Pdfurl({Key? key}) : super(key: key);

  @override
  _PdfurlState createState() => _PdfurlState();
}

class _PdfurlState extends State<Pdfurl> {
  Documents? doc;
 @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child:

              // Image.network("https://his-erp.com/${common.docLink}")

              SfPdfViewer.network("https://his-erp.com/${common.docLink}",
                  onDocumentLoadFailed: (ispdf) {
        Image.network("https://his-erp.com/${common.docLink}");
      })),
    );
  }
}

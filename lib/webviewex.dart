import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewEx extends StatefulWidget {
  const WebViewEx({Key? key}) : super(key: key);

  @override
  _WebViewExState createState() => _WebViewExState();
}

class _WebViewExState extends State<WebViewEx> {
  bool isloading = true;
  bool webViewLoading = false;
  int progressVal = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            WebView(
              initialUrl: "https://i-infoway.com/",
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (str) {
                print("onPageStarted");
                setState(() {
                  webViewLoading = true;
                });
              },
              onPageFinished: (str) {
                print("onPageFinished");
                setState(() {
                  webViewLoading = false;
                });
              },
              onProgress: (progress) {
                print("onProgress $progress");
                setState(() {
                  progressVal = progress;
                });
              },
              gestureNavigationEnabled: true,
            ),
            if (webViewLoading) ...[
              Center(
                child: CircularProgressIndicator(
                  value: progressVal.toDouble() / 100,
                  strokeWidth: 2,
                  backgroundColor: Colors.blue,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Center(
                child: Text("$progressVal"),
              )
            ]
          ],
        ),
      ),
    );
  }
}

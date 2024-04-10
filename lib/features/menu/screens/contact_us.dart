

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  WebViewController? controller;
  bool loading = true;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              loading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              loading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('https://avrod.com/contact-avrod/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Help',style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body:loading ?
        Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ):
        WebViewWidget(controller: controller!)
    );
  }



}

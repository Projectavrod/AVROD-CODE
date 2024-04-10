import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

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
      ..loadRequest(Uri.parse('https://avrod.com/terms-and-conditions/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Policy',style: TextStyle(color: Colors.black),),
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

  Widget h1(String text){
    return Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),);
}
  Widget h2(String text){
    return Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),);
  }

  Widget textWithBullet(String text){
    return Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),);
  }

}

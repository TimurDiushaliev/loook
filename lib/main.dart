import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:loook/connectionFalse.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: WebViewPage()));

check(context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    print('It is using mobile connection');
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print('It is using Wi-fi connection');
  } else {
    print('connection isnt defined');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ConnectionFailedPage()));
  }
}

checkNetwork(context) async {
  String url = 'https://jsonplaceholder.typicode.com/posts/1';
  try {
    var response = await http.post(url);
    print('Json Placeholder response: ${json.decode(response.body)}');
  } on SocketException catch (e) {
    print('Socket exception $e');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ConnectionFailedPage()));
  }
}

class WebViewPage extends StatefulWidget {
  WebViewPage({Key key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  StreamSubscription<ConnectivityResult> networkSubscription;
  @override
  void initState() {
    super.initState();
    Scaffold(
      appBar: AppBar(),
      body: Image.asset(
        'images/welcome.png',
        fit: BoxFit.cover,
      ),
    );
    networkSubscription = Connectivity().onConnectivityChanged.listen((result) {
      print('The result of network subcription: $result');
      check(context);
    });
    checkNetwork(context);
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      //this is our website
      url: 'https://loook.kg',
      withLocalStorage: true,
      initialChild: Scaffold(
        body: Image.asset(
          'images/welcome.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

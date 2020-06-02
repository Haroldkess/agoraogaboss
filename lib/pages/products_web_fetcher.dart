
import 'package:agora_ogaboss/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';


class MyHustle extends StatefulWidget {
  final String tittle;

  MyHustle({Key key, this.tittle}) : super(key: key);

  @override
  _MyHustleState createState() => _MyHustleState();
}

class _MyHustleState extends State<MyHustle> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title:  Center(
          child: Text(
            'Agora',
            style: TextStyle(
              color: Colors.white,

              fontSize: 30.0,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.yellow,
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
            ),),
        ],
        elevation: 50.0,
        backgroundColor: Colors.black,
        iconTheme:  IconThemeData(color: Colors.green),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebView(
            initialUrl: 'https://web.ogaboss.online/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            gestureRecognizers: Set()
              ..add(Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer())),
          );
        },
      ),
    );
  }
}

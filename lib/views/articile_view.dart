import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {

  final String blogUrl;


  ArticleView({this.blogUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override

  final Completer<WebViewController> _completer =
  Completer<WebViewController>();

  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }


  Widget build(BuildContext context) {
    print('api link ${widget.blogUrl}');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Div',style: GoogleFonts.roboto(color: Colors.black,fontWeight: FontWeight.bold),),
            Text('News',style: GoogleFonts.roboto(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
          ],
        ),
        actions: [

          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: WebView(
          initialUrl: widget.blogUrl,
          // onWebViewCreated: ((WebViewController webViewController){_completer.complete(webViewController);}),
        ),
      ),
    );
  }
}

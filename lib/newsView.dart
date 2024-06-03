import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsView extends StatefulWidget {
  final String url;

  NewsView(this.url);

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late String finalUrl;
  @override
  void initState() {
    if (widget.url.toString().contains("http://")) {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    // Create a WebUri object using the constructor
    WebUri webUri = WebUri(finalUrl);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NewsFlash",

          style: TextStyle(color: Colors.yellow),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.yellow),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: webUri),
      ),
    );
  }
}

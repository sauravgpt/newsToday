import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  final isDarkMode;

  WebViewContainer(this.url, this.isDarkMode);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  bool isLoading = true;

  _WebViewContainerState(this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.access_alarm),
              ),
            )
          ],
          iconTheme: IconThemeData(
            color: widget.isDarkMode ? Colors.white : Colors.black45,
          ),
          backgroundColor: !widget.isDarkMode ? Colors.white : Colors.black45,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'News',
                style: TextStyle(
                  fontSize: 25,
                  color: widget.isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          elevation: 0.0,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(children: [
              WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: _url,
                onWebResourceError: (error) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Unable to launch $error')));
                  Navigator.pop(context);
                },
                onPageFinished: (finished) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading ? LinearProgressIndicator() : Stack(),
            ]),
          ),
        ],
      ),
    );
  }
}

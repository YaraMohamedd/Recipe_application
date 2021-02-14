import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:recipe_application/widgets/app_bar_style.dart';
import 'package:recipe_application/services/dynamic_theme.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
class RecipeViewScreen extends StatefulWidget {
  final String postUrl;
  RecipeViewScreen ({@required this.postUrl});
  @override
  _RecipeViewScreenState createState() => _RecipeViewScreenState();
}

class _RecipeViewScreenState extends State<RecipeViewScreen> {
 final Completer<WebViewController> _controller=    Completer<WebViewController>();
 String finalUrl;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalUrl=widget.postUrl;
    if(widget.postUrl.contains('http://')){
      finalUrl = widget.postUrl.replaceAll("http://","https://");
      print(finalUrl + "this is final url");
    }
 }
 void changeBrightness() {
   DynamicTheme.of(context).setBrightness(
     Theme.of(context).brightness == Brightness.dark
         ? Brightness.light
         : Brightness.dark,
   );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: AppBarTitle(),
        actions: [
          IconButton(
            icon: Icon(
                isThemeDark(context) ? Icons.wb_sunny : Icons.brightness_2),
            color: isThemeDark(context) ? Colors.white : Colors.black,
            onPressed: () {
              setState(() {
                changeBrightness();
              });
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: WebView(
          onPageFinished: (val){
            print(val);
          },
          javascriptMode:  JavascriptMode.unrestricted,
          initialUrl: finalUrl,
          onWebViewCreated: (WebViewController webViewController){
            setState(() {
              _controller.complete(webViewController);
            });
          },
        ),
      ),
    );
  }
}

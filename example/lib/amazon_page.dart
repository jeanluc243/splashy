import 'package:flutter/material.dart';
import 'package:splashy/splashy.dart';

class Amazon extends StatelessWidget {
  Future<Widget> customFunction() {
    print("Background process");
    return Future.value(AmazonHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Splashy(
        imagePath: "assets/amazon.jpg",
        customFunction: customFunction(),
        curve: Curves.linear,
      ),
    );
  }
}

class AmazonHomePage extends StatefulWidget {
  @override
  _AmazonHomePageState createState() => _AmazonHomePageState();
}

class _AmazonHomePageState extends State<AmazonHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amazon"),
      ),
      body: Center(
        child: Text("Hello World From Amazon"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:splashy/splashy.dart';

class Linkedin extends StatelessWidget {
  Future<Widget> customFunction() {
    print("Background process");
    return Future.value(LinkedinHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Splashy(
        imagePath: "assets/linkindin.png",
        backgroundColor: Color(0xFF066dae),
        customFunction: customFunction(),
        curve: Curves.linear,
        duration: 2000,
      ),
    );
  }
}

class LinkedinHomePage extends StatefulWidget {
  @override
  _LinkedinHomePageState createState() => _LinkedinHomePageState();
}

class _LinkedinHomePageState extends State<LinkedinHomePage> {
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

import 'package:flutter/material.dart';
import 'package:splashy/splashy.dart';

void main() {
  Future<Widget> customFunction() {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100) return Future.value(Home1());
    // return Future.value(null);
    // else
    //   return Future.value(HomeSt());
  }

  runApp(MaterialApp(
    home: Splashy(
      imagePath: "assets/flutter_icon.png",
      style: AnimationStyle.Scale,
      curve: Curves.decelerate,
      backgroundColor: Colors.red,
      logoHeight: 150,
      logoWidth: 150,
      // duration: 10000,
      bottomLoader: CircularProgressIndicator(),

      customFunction: customFunction(),
      // home: HomePage(),
    ),
  ));
}

class Home1 extends StatefulWidget {
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splashy"),
      ),
      body: Center(
        child: Text("1"),
      ),
    );
  }
}

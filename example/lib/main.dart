import 'package:flutter/material.dart';
import 'package:splashy/splashy.dart';


void main(){
    Future<Widget> customFunction() {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return Future.value(Home());
    // else
    //   return Future.value(HomeSt());
  }

  runApp(MaterialApp(
    home: AnimatedSplash(
      imagePath: "assets/flutter_icon.png",
      customFunction: customFunction(),
      // home: HomePage(),
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("1"),),
    );
  }
}
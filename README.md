![Animated Flat Camera Icon by Kushagra Agarwal](assets/splashy.gif)
[Animated Flat Camera Icon](https://dribbble.com/shots/1074938--GIF-Animated-Flat-Camera-Icon) by Kushagra Agarwal

<hr>

[![Pub](https://img.shields.io/pub/v/splashy.svg?style=flat-square)](https://pub.dartlang.org/packages/splashy)
[![Star on GitHub](https://img.shields.io/github/stars/jeanluc243/splashy.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/jeanluc243/splashy)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![Flutter Website](https://img.shields.io/badge/flutter-website-deepskyblue.svg)](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#bloc--rx)
[![Awesome Flutter](https://img.shields.io/badge/awesome-flutter-blue.svg?longCache=true)](https://github.com/Solido/awesome-flutter#standard)
[![Flutter Samples](https://img.shields.io/badge/flutter-samples-teal.svg?longCache=true)](http://fluttersamples.com)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

<hr>

Splash Screen is the first visual users see when an application is launched.

One might wonder what is ‘splashy’ about Splash Screen. Frankly, very little! Its chief purpose is to engage users while the app loads. And in order to do that, it may feel like a of splash of visuals virtually thrown them.

<small>package inspired from [Splash Screen: Designing a Successful Launch Experience for Your Mobile App](https://blog.mobile-patterns.com/splash-screen-designing-a-successful-launch-experience-for-your-mobile-app-b0b70a0ef32d) of [Maitrik Kataria
](https://blog.mobile-patterns.com/@maitrikkataria?source=post_page-----b0b70a0ef32d----------------------)</small>

📦 Splashy is a fork of [animated_splash](https://github.com/fayaz07/splash_screen)

## Using the package 

```dart
import 'package:flutter/material.dart';
import 'package:splashy/splashy.dart';

void main(){

    Future<Widget> customFunction(){
        print("Background process");
        return Future.value(HomPage())
    }

    runApp(MaterialApp(
        home: Splashy(
            imagePath: "assets/flutter_icon.png",
            curve : Curves.easeInOut,
            backgroundColor : Colors.blue,
            customFunction: customFunction(),
        )
    ));
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splashy"),
      ),
      body: Center(child: Text("Hello World"),),
    );
  }
}

```

library splashy;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum AnimationStyle { CircularReveal, FadeIn, Still, Scale }
enum Config { Default, Styled, Custom }

// ignore: must_be_immutable
class Splashy extends StatefulWidget {
  Future<Widget> _backgroundProcess;
  String _imagePath;
  int _duration = 1000;
  Color _backgroundColor = Colors.white;
  double _logoHeight = 200.0, _logoWidth = 200.0;
  Config _configStyle = Config.Default;
  Widget _child;
  AnimationStyle _animationStyle = AnimationStyle.FadeIn;
  Widget _bottomLoader;
  Curve _animCurve = Curves.easeInOutCirc;

  Splashy(
      {@required String imagePath,
      @required Future<Widget> customFunction,
      AnimationStyle style,
      Curve curve,
      int duration,
      Color backgroundColor,
      double logoHeight,
      double logoWidth,
      Widget bottomLoader}) {
    assert(imagePath != null);
    assert(customFunction != null);
    _backgroundProcess = customFunction;
    _configStyle = Config.Styled;
    _imagePath = imagePath;
    _animationStyle = style;
    _animCurve = curve;
    _bottomLoader = bottomLoader;
    _backgroundColor = backgroundColor ?? _backgroundColor;
    _logoHeight = logoHeight ?? _logoHeight;
    _logoWidth = logoWidth ?? _logoWidth;
    _duration = duration ?? _duration;
    if (_duration < 1000) _duration = 1000;
  }

  @override
  _SplashyState createState() => _SplashyState();
}

class _SplashyState extends State<Splashy> with TickerProviderStateMixin {
  //  For fade animation
  AnimationController _animationController;
  Animation _animation;

  // For Circular Reveal animation
  Animation scaleAnim, radiusAnim;
  AnimationController scaleAnimController, radiusAnimController;
  final animDuration = Duration(milliseconds: 150);
  bool initialCase = true;
  MaterialType materialType = MaterialType.circle;
  double _height, _width;

  //  Default requirements
  bool _isAnimCompleted = false, _isBackgroundProcessCompleted = false;
  Widget _homeAfterBackgroundProcess;

  @override
  void initState() {
    if (widget._animationStyle != AnimationStyle.CircularReveal) {
      _animationController = new AnimationController(
          vsync: this, duration: Duration(milliseconds: widget._duration));
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController, curve: widget._animCurve));
      widget._configStyle == Config.Custom
          ? debugPrint(
              "Animated controller is not started as config style is custom")
          : _animationController.forward();
      _animation.addStatusListener(defaultAnimationsStatusListener);
    }

    if (widget._animationStyle == AnimationStyle.CircularReveal) {
      //  For Circular reveal animation
      scaleAnimController = AnimationController(
          vsync: this,
          duration: animDuration,
          debugLabel: 'SplashScreen-CircleAnim');
      scaleAnim = Tween(begin: 0.7, end: 1.0).animate(scaleAnimController);

      radiusAnimController = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 10),
          debugLabel: 'SplashScreen-CircleAnim');
      radiusAnim = Tween(begin: 1.0, end: 0.0).animate(radiusAnimController);

      Future.delayed(Duration(seconds: 2)).whenComplete(() {
        scaleAnimController.forward();
      });

      scaleAnimController.addListener(circularAnimationListener);
    }
    super.initState();
  }

  circularAnimationListener() {
    if (scaleAnim.value > 0.9 && _height == _width) {
      setState(() {
        _height = MediaQuery.of(context).size.height;
      });
      radiusAnimController.forward();
    }
    if (scaleAnimController.status == AnimationStatus.completed) {}
    if (scaleAnim.status == AnimationStatus.completed) _isAnimCompleted = true;
    if (_isAnimCompleted && _isBackgroundProcessCompleted) {
      debugPrint(
          "Background Process completed before Animation, navigating to $_homeAfterBackgroundProcess");
      _navigator(_homeAfterBackgroundProcess);
    }
  }

  @override
  void dispose() {
    if (widget._animationStyle != AnimationStyle.CircularReveal) {
      _animation.removeStatusListener(defaultAnimationsStatusListener);
      _animationController.reset();
    }
    if (widget._animationStyle == AnimationStyle.CircularReveal) {
      scaleAnim.removeListener(circularAnimationListener);
    }
    super.dispose();
  }

  defaultAnimationsStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _isAnimCompleted = true;
    if (_isAnimCompleted && _isBackgroundProcessCompleted) {
      debugPrint(
          "Background Process completed before Animation, navigating to $_homeAfterBackgroundProcess");
      _navigator(_homeAfterBackgroundProcess);
    }
  }

  _navigator(home) {
    Navigator.of(context).pushReplacement(Platform.isAndroid
        ? MaterialPageRoute(builder: (BuildContext context) => home)
        : CupertinoPageRoute(builder: (BuildContext context) => home));
  }

  _goBackground() => widget._backgroundProcess.then((Widget home) {
        debugPrint("Background process completed its execution");
        if (widget._configStyle == Config.Custom) _navigator(home);
        if (_isAnimCompleted) {
          debugPrint(
              "Animation completed before Background process, navigating to $home");
          _navigator(home);
        }
        _isBackgroundProcessCompleted = true;
        _homeAfterBackgroundProcess = home;
      });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((Duration d) => _goBackground());

    if (initialCase) {
      _width = MediaQuery.of(context).size.width;
      _height = _width;
      initialCase = false;
    }

    return Scaffold(
      backgroundColor: widget._backgroundColor,
      body: widget._configStyle == Config.Custom
          ? widget._child
          : _getAnimatedBuilder(),
    );
  }

  Widget _getAnimatedBuilder() {
    switch (widget._animationStyle) {
      case AnimationStyle.CircularReveal:
        return _circularRevealAnimatedLogo();
      case AnimationStyle.FadeIn:
        return Stack(
          children: [
            Positioned(
                child: Align(
              alignment: Alignment.center,
              child: Align(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: _animation,
                  child: Center(
                    child: Image.asset(
                      widget._imagePath,
                      height: widget._logoHeight,
                      width: widget._logoWidth,
                    ),
                  ),
                ),
              ),
            )),
            Positioned(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 90.0),
                child: widget._bottomLoader,
              ),
            ))
          ],
        );

      case AnimationStyle.Still:
        return Stack(
          children: [
            Positioned(
                child: Align(
              alignment: Alignment.center,
              child: Center(
                child: Image.asset(widget._imagePath,
                    height: widget._logoHeight, width: widget._logoWidth),
              ),
            )),
            Positioned(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: widget._bottomLoader,
              ),
            ))
          ],
        );
      case AnimationStyle.Scale:
        return Stack(
          children: [
            Positioned(
                child: Align(
              alignment: Alignment.center,
              child: SizeTransition(
                sizeFactor: _animation,
                child: Center(
                  child: Image.asset(widget._imagePath,
                      height: widget._logoHeight, width: widget._logoWidth),
                ),
              ),
            )),
            Positioned(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: widget._bottomLoader,
              ),
            ))
          ],
        );

      default:
        return Stack(
          children: [
            Positioned(
                child: Align(
              alignment: Alignment.center,
              child: Center(
                child: Image.asset(widget._imagePath,
                    height: widget._logoHeight, width: widget._logoWidth),
              ),
            )),
            Positioned(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: widget._bottomLoader,
              ),
            ))
          ],
        );
    }
  }

  Widget _circularRevealAnimatedLogo() => Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: scaleAnim,
            builder: (context, child) {
              return Center(
                child: Container(
                  width: _width * scaleAnim.value,
                  height: _height * scaleAnim.value,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius:
                          BorderRadius.circular(_width * radiusAnim.value)),
                ),
              );
            },
          ),
          Center(
            child: Image.asset(widget._imagePath, height: widget._logoHeight),
          ),
        ],
      );
}

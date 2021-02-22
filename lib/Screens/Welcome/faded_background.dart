import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


class FadedScreen extends StatefulWidget {
  final Image child;

  const FadedScreen({Key key, this.child}) : super(key: key);
  @override
  _FadedScreenState createState() => _FadedScreenState();
}

class _FadedScreenState extends State<FadedScreen> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    // TODO: implement initState
    _controller=AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    );
    _animation= Tween(
      begin: 0.0,
      end: 12.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    return FadeTransition(
        opacity: _animation,
      child: widget.child,
    );
  }
}

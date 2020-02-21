import 'package:flutter/material.dart';

void main() => runApp(BouncingButton());

class BouncingButton extends StatefulWidget {
  final Widget child;
  final Function onPressed;

  BouncingButton({this.child, this.onPressed});

  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 25),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse(from: 0.1);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  widget.onPressed();
                  _controller.forward();
                },
                child: Transform.scale(
                  scale: _scale,
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

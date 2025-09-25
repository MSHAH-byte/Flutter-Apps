import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _buttonRadius = 100;
  final Tween<double> backgroundScale = Tween<double>(begin: 0.0, end: 0.1);
  AnimationController? _starAnimationController;

  @override
  void initState() {
    super.initState();
    _starAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _starAnimationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _pageBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [circularAnimationButton(), starIcon()],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeInOutCubicEmphasized,
      duration: Duration(seconds: 1),
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: Container(color: Colors.blue),
    );
  }

  Widget circularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _buttonRadius += _buttonRadius == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          curve: Curves.bounceInOut,
          duration: const Duration(seconds: 2),
          height: _buttonRadius,
          width: _buttonRadius,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          child: const Center(
            child: Text("Basics!", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget starIcon() {
    return AnimatedBuilder(
      animation: _starAnimationController!.view,
      builder: (buildContext, child) {
        return Transform.rotate(
          angle: _starAnimationController!.value * 2 * pi,
          child: child,
        );
      },
      child: const Icon(Icons.star, size: 100, color: Colors.white),
    );
  }
}

import 'package:flutter/material.dart';

class EnterAnimations {
  EnterAnimations(this.controller) {
    circleSize = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutBack));
  }

  final AnimationController controller;
  late final Animation<double> circleSize;
}

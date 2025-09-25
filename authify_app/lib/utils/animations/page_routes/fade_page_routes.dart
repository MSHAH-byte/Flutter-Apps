import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget _child;

  FadePageRoute(this._child)
    : super(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return _child;
            },
      );
}

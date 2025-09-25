import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget _child;

  SlidePageRoute(this._child)
    : super(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation, // Correct type
              Animation<double> secondaryAnimation, // Correct type
              Widget child,
            ) {
              // Use the animation provided to create an animated value
              Animation<Offset> slideAnimation = Tween<Offset>(
                begin: const Offset(-1, 0),
                end: const Offset(0, 0),
              ).animate(animation);

              return SlideTransition(position: slideAnimation, child: child);
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

import 'package:flutter/material.dart';

enum RouteTransitionType {
  slide,
  fade,
  scale,
  none,
}

class RouteTransitions {
  static PageRouteBuilder<T> slideTransition<T extends Object?>({
    required Widget page,
    required RouteSettings settings,
    Offset begin = const Offset(1.0, 0.0),
    Offset end = Offset.zero,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: end,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  static PageRouteBuilder<T> fadeTransition<T extends Object?>({
    required Widget page,
    required RouteSettings settings,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: curve,
          ),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  static PageRouteBuilder<T> scaleTransition<T extends Object?>({
    required Widget page,
    required RouteSettings settings,
    double begin = 0.0,
    double end = 1.0,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: begin,
            end: end,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  static PageRouteBuilder<T> getTransition<T extends Object?>({
    required RouteTransitionType type,
    required Widget page,
    required RouteSettings settings,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    switch (type) {
      case RouteTransitionType.slide:
        return slideTransition<T>(
          page: page,
          settings: settings,
          duration: duration,
          curve: curve,
        );
      case RouteTransitionType.fade:
        return fadeTransition<T>(
          page: page,
          settings: settings,
          duration: duration,
          curve: curve,
        );
      case RouteTransitionType.scale:
        return scaleTransition<T>(
          page: page,
          settings: settings,
          duration: duration,
          curve: curve,
        );
      case RouteTransitionType.none:
        return PageRouteBuilder<T>(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
        );
    }
  }
}


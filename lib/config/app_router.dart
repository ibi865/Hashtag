import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../view/screens/screen_a.dart';
import '../view/screens/screen_b.dart';
import '../view/screens/screen_c.dart';
import '../view_model/screen_a_vm.dart';
import '../view_model/screen_b_vm.dart';
import '../view_model/screen_c_vm.dart';
import 'app_routes.dart';
import 'route_transitions.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.screenA,
    routes: [
      _buildScreenARoute(),
      _buildScreenBRoute(),
      _buildScreenCRoute(),
    ],
  );

  static GoRoute _buildScreenARoute() {
    return GoRoute(
      path: AppRoutes.screenA,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: ChangeNotifierProvider(
            create: (_) => ScreenAVm(),
            child: const ScreenA(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return RouteTransitions.getTransition(
              type: RouteTransitionType.slide,
              page: child,
              settings: RouteSettings(name: state.uri.path, arguments: state.extra),
            ).transitionsBuilder(context, animation, secondaryAnimation, child);
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  static GoRoute _buildScreenBRoute() {
    return GoRoute(
      path: AppRoutes.screenB,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: ChangeNotifierProvider(
            create: (_) {
              final vm = ScreenBVm();
              // Initialize from route parameters if available
              final phrase = state.uri.queryParameters['phrase'];
              final hashtags = state.uri.queryParameters['hashtags'];
              if (phrase != null || hashtags != null) {
                vm.phrase = phrase;
                vm.hashtags = hashtags;
              }
              return vm;
            },
            child: const ScreenB(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return RouteTransitions.getTransition(
              type: RouteTransitionType.slide,
              page: child,
              settings: RouteSettings(name: state.uri.path, arguments: state.extra),
            ).transitionsBuilder(context, animation, secondaryAnimation, child);
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  static GoRoute _buildScreenCRoute() {
    return GoRoute(
      path: AppRoutes.screenC,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: ChangeNotifierProvider(
            create: (_) => ScreenCVm(),
            child: const ScreenC(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return RouteTransitions.getTransition(
              type: RouteTransitionType.slide,
              page: child,
              settings: RouteSettings(name: state.uri.path, arguments: state.extra),
            ).transitionsBuilder(context, animation, secondaryAnimation, child);
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}


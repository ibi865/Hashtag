import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_vm.dart';
import '../config/app_routes.dart';

class ScreenBVm extends BaseViewModel {
  String? _phrase;
  String? _hashtags;

  String? get phrase => _phrase;
  String? get hashtags => _hashtags;

  bool get hasData => (_phrase?.isNotEmpty ?? false) || (_hashtags?.isNotEmpty ?? false);

  void setData(String? phrase, String? hashtags) {
    _phrase = phrase;
    _hashtags = hashtags;
    notifyListeners();
  }

  void navigateToScreenC(BuildContext context, String route) {
    context.push(route);
  }

  void navigateBackToScreenA(BuildContext context) {
    // Show dialog first, then navigate back when OK is clicked
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xff0d121e),
          title: const Text(
            'Congratulations 🎉',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // Navigate back to Screen A after dialog is closed
                context.go(AppRoutes.screenA);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xff15a5be),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


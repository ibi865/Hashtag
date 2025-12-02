import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_vm.dart';

class ScreenBVm extends BaseViewModel {
  String? phrase;
  String? hashtags;

  bool get hasData => (phrase?.isNotEmpty ?? false) || (hashtags?.isNotEmpty ?? false);

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
          content: const Text(
            'Congratulations 🎉',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // Navigate back to Screen A after dialog is closed
                context.pop();
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


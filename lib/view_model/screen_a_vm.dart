import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_vm.dart';

class ScreenAVm extends BaseViewModel {
  void navigateToScreenB(BuildContext context, String route) {
    context.push(route);
  }
}


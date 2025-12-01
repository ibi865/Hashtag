import 'package:flutter/material.dart';
import 'package:zakat/data/base_vm.dart';

class ConvertVm extends BaseVm {
  ConvertVm(){
        // activeController = fromController; // default first field active


  }
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> convert(BuildContext context) async {
    if (isLoading) return;
    try {
      isLoading = true;
      // TODO: Implement actual convert logic here
      await Future.delayed(const Duration(seconds: 1));
    } catch (_) {
    } finally {
      isLoading = false;
    }
  }
  // late TextEditingController activeController;
  // void onKeyTap(String value) {
  //     activeController.text += value;
  //     notifyListeners();
  // }

  // void onBackspace() {
  //     if (activeController.text.isNotEmpty) {
  //       activeController.text =
  //           activeController.text.substring(0, activeController.text.length - 1);
  //     }
  //     notifyListeners();
  // }
}

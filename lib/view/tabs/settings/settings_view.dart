import 'package:flutter/material.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/tabs/settings/settings_vm.dart';
import 'package:zakat/widgets/custom_button.dart';

import '../../../utils/app_constants.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const String routeName = '/SettingsView';

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsVm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 15.h),
          child: vm.walletAddress.isNotEmpty ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             
              Expanded(
                child: CustomButton(
                  onTap: () {vm.logOut();},
                  text: 'Logout',
                  height: 44.h,
                  buttonColor: AppColors.btnColor,
                  borderRadius: 8.r,
                ),
              ),
            ],
          ) : CustomButton(
            onTap: () {vm.logOut();},
            text: 'Logout',
            height: 44.h,
            buttonColor: AppColors.btnColor,
            borderRadius: 8.r,
          ),
        ),
      ),
    );
  }
}

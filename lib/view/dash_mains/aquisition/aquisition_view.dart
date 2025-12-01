import 'package:flutter/material.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/dash_mains/aquisition/aquisition_vm.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/sb.dart';

class AquisitionView extends StatelessWidget {
  const AquisitionView({super.key});
  static const String route = '/AquisitionView';

  @override
  Widget build(BuildContext context) {
    return Consumer<AquisitionVm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded, color: AppColors.btnColor),
          ),
          title: CustomText(
            text: 'Aquisition Based Giving',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none_rounded, color: Colors.white),
            ),
          ],
        ),
        body: Column(
          children: [
            SB.h(20.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Zakat Percentage',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Slider(
                        value: 25,
                        min: 0,
                        max: 100,
                        activeColor: AppColors.btnColor,
                        inactiveColor: Colors.grey.withOpacity(0.4),
                        thumbColor: Colors.grey,
                        onChanged: (val) => (),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SB.h(20.h),
          ],
        ),
      ),
    );
  }
}

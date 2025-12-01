import 'package:flutter/material.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/utils/extension.dart';
import 'package:zakat/view/dash_mains/payment/payment_view.dart';
import 'package:zakat/view/start/connectBank/connectBank_view.dart';
import 'package:zakat/view/start/importCreateSelection/importCreateSelection_vm.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/sb.dart';

class ImportcreateselectionView extends StatelessWidget {
  const ImportcreateselectionView({super.key});
  static const String route = '/ImportcreateselectionView';

  @override
  Widget build(BuildContext context) {
    return Consumer<ImportcreateselectionVm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Stack(
          children: [
            Positioned(
              bottom: -context.height * 0.08,
              child: Image.asset('wave'.toPngPath, width: context.width),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SB.h(2),
                SvgPicture.asset(
                  'login'.toSvgPath,
                  width: 310.w,
                  height: 222.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.08,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      walletTile('new', context),
                      SB.h(20.h),
                      walletTile('existing', context),
                      SB.h(20.h),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget walletTile(String walletType, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (walletType == 'new') {
          
        } else {}
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.btnColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: walletType == 'new'
                    ? Icon(
                        Icons.add_rounded,
                        color: Colors.black87,
                        size: 28.sp,
                      )
                    : Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.black87,
                        size: 28.sp,
                      ),
              ),
            ),
            SB.w(12.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: walletType == 'new'
                      ? 'Create a new wallet'
                      : 'Add existing wallet',
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: walletType == 'new'
                      ? 'Secret phrase or swift wallet'
                      : 'Import, restore or view only',
                  color: AppColors.btnColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import '../../widgets/custom_text.dart';
import 'bottom_nav_vm.dart';

class BottomNav extends StatelessWidget {
  static const String route = '/bottomNav';
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavVm>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: vm.pages[vm.selectedIndex],
        bottomNavigationBar: _GlassBottomBar(
          currentIndex: vm.selectedIndex,
          onTap: (i){
            if(i == 2){
              vm.showDonationBottomSheet(context);
            }
            else{
              vm.selectedIndex = i;
            }
          },
        ),
      );
    });
  }
}

class _GlassBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _GlassBottomBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 55.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NavItem(
              label: 'Dashboard',
              asset: 'dashboard',
              selected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              label: 'Reward',
              asset: 'reward',
              selected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            _NavItem(
              label: 'Donations',
              asset: 'donation',
              selected: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavItem(
              label: 'DAO',
              asset: 'dao',
              selected: currentIndex == 3,
              onTap: () => onTap(3),
            ),
            _NavItem(
              label: 'Setting',
              asset: 'setting',
              selected: currentIndex == 4,
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final String asset;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.asset,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.btnColor : Colors.white;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            asset == 'setting' ? Icon(Icons.settings,color: color) : SvgPicture.asset(
              asset.toBottomNavPath,
              height: 22.h,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            SizedBox(height: 6.h),
            CustomText(
              text: label,
              fontWeight: FontWeight.w700,
              fontSize: 11.sp,
              color: color,
            )
          ],
        ),
      ),
    );
  }
}


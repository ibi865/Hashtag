import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat/helper/shared_preferences.dart';
import 'package:zakat/view/bottomNav/bottom_nav.dart';
import 'package:zakat/view/bottomNav/bottom_nav_vm.dart';
import 'package:zakat/view/dash_mains/aquisition/aquisition_view.dart';
import 'package:zakat/view/dash_mains/aquisition/aquisition_vm.dart';
import 'package:zakat/view/dash_mains/holdList/holdList_view.dart';
import 'package:zakat/view/dash_mains/holdList/holdList_vm.dart';
import 'package:zakat/view/dash_mains/payment/payment_view.dart';
import 'package:zakat/view/dash_mains/payment/payment_vm.dart';
import 'package:zakat/view/dash_mains/scan/scan_view.dart';
import 'package:zakat/view/dash_mains/scan/scan_vm.dart';
import 'package:zakat/view/dash_mains/scanList/scanList_view.dart';
import 'package:zakat/view/dash_mains/scanList/scanList_vm.dart';
import 'package:zakat/view/dash_mains/zakPay/zakPay_view.dart';
import 'package:zakat/view/dash_mains/zakPay/zakPay_vm.dart';
import 'package:zakat/view/bottomNav/bottom_nav.dart';
import 'package:zakat/view/bottomNav/bottom_nav_vm.dart';
import 'package:zakat/view/dash_mains/aquisition/aquisition_view.dart';
import 'package:zakat/view/dash_mains/aquisition/aquisition_vm.dart';
import 'package:zakat/view/dash_mains/holdList/holdList_view.dart';
import 'package:zakat/view/dash_mains/holdList/holdList_vm.dart';
import 'package:zakat/view/dash_mains/payment/payment_view.dart';
import 'package:zakat/view/dash_mains/payment/payment_vm.dart';
import 'package:zakat/view/dash_mains/scan/scan_view.dart';
import 'package:zakat/view/dash_mains/scan/scan_vm.dart';
import 'package:zakat/view/dash_mains/scanList/scanList_view.dart';
import 'package:zakat/view/dash_mains/scanList/scanList_vm.dart';
import 'package:zakat/view/start/connectBank/connectBank_view.dart';
import 'package:zakat/view/start/connectBank/connectBank_vm.dart';
import 'package:zakat/view/start/importCreateSelection/importCreateSelection_view.dart';
import 'package:zakat/view/start/importCreateSelection/importCreateSelection_vm.dart';
import 'package:zakat/view/start/login/login_view.dart';
import 'package:zakat/view/start/login/login_vm.dart';
import 'package:zakat/view/start/onboarding/onboarding_view.dart';
import 'package:zakat/view/start/onboarding/onboarding_vm.dart';
import 'package:zakat/view/start/signUp/signUp_view.dart';
import 'package:zakat/view/start/signUp/signUp_vm.dart';
import 'package:zakat/view/start/splash/splash_screen.dart';
import 'package:zakat/view/start/splash/splash_vm.dart';
import 'package:zakat/view/dash_mains/convert/convert_view.dart';
import 'package:zakat/view/dash_mains/convert/convert_vm.dart';
import 'package:zakat/widgets/comingSoon.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  MySharedPrefrences.setStringData(key: 'route', value: settings.name!);

  switch (settings.name) {
    case SplashScreen.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => SplashVm(context),
          child: const SplashScreen(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case OnboardingView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => OnboardingVm(),
          child: const OnboardingView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case ImportcreateselectionView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => ImportcreateselectionVm(),
          child: const ImportcreateselectionView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case ConnectbankView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => ConnectbankVm(),
          child: const ConnectbankView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );

    case LoginScreen.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => LoginVm(),
          child: const LoginScreen(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case SignupView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => SignupVm(),
          child: const SignupView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case ConvertView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => ConvertVm(),
          child: const ConvertView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case HoldlistView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => HoldlistVm(),
          child: const HoldlistView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case ScanlistView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => ScanlistVm(),
          child: const ScanlistView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case ScanView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => ScanVm(),
          child: const ScanView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case AquisitionView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => AquisitionVm(),
          child: const AquisitionView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case PaymentView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => PaymentVm(),
          child: const PaymentView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case BottomNav.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => BottomNavVm(),
          child: const BottomNav(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case ZakpayView.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: (context) => ZakpayVm(),
          child: const ZakpayView(),
        ),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );
    case Comingsoon.route:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => const Comingsoon(),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeInOut)),
          child: c,
        ),
        transitionDuration: const Duration(
          milliseconds: 300,
        ), // Set a custom duration for the transition
      );

    default:
      return errorRoute(settings.name);
  }
}

Route<dynamic> errorRoute(String? route) {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Arggg!', style: TextStyle(color: Colors.black)),
        ),
        body: Center(child: Text('Oh No! You should not be here $route!')),
      );
    },
  );
}

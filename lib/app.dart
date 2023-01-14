import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvvm_template/core/services/localization_service.dart';
import 'package:mvvm_template/ui/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  final String title;

  //TODO update the _designWidth and _designHeight according to your figma design
  static const double _designWidth = 375;
  static const double _designHeight = 812;
  const MyApp({required this.title, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(_designWidth, _designHeight),
      builder: (context, widget) => GetMaterialApp(
        translations: LocalizationService(),
        locale: const Locale("en"),
        title: title,
        home: const SplashScreen(),
      ),
    );
  }
}

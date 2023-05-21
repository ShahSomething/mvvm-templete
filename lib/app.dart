import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_template/core/Routes/route_generator.dart';
import 'package:mvvm_template/core/Routes/routes.dart';
import 'package:mvvm_template/core/services/navigation_service.dart';
import 'package:mvvm_template/core/theme/custom_theme.dart';

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
      builder: (context, widget) => MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        locale: const Locale("en"),
        title: title,
        theme: CustomTheme.lightTheme,
        themeMode: ThemeMode.light,
        initialRoute: AppRoutes.splashScreenRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

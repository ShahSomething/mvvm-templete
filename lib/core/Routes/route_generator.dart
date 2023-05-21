import 'package:flutter/material.dart';
import 'package:mvvm_template/core/Routes/routes.dart';
import 'package:mvvm_template/core/constants/styles.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_logger.dart';
import 'package:mvvm_template/ui/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:mvvm_template/ui/screens/authentication/login_screen/login_screen.dart';
import 'package:mvvm_template/ui/screens/navigation/navigation_screen.dart';
import 'package:mvvm_template/ui/screens/onboarding/onboarding_screen.dart';
import 'package:mvvm_template/ui/screens/splash_screen.dart';

class RouteGenerator {
  static final log = CustomLogger(className: 'RouteGenerator');
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    log.wtf("@RouteGenerator/generateRoute ${settings.name}");
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginScreen(),
        );
      case AppRoutes.loginRoute:
        arguments;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginScreen(),
        );
      case AppRoutes.splashScreenRoute:
        arguments;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );
      case AppRoutes.onboardingRoute:
        var providedArguments = arguments as dynamic;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OnboardingScreen(
            onboardingList: providedArguments.onboardingList,
            preCachedImages: providedArguments.preCachedImages,
            currentIndex: providedArguments.currentIndex,
          ),
        );
      case AppRoutes.navigationRoute:
        arguments;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const NavigationScreen(),
        );
      case AppRoutes.forgotPasswordRoute:
        arguments;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ForgetPasswordScreen(),
        );

      //TODO add all the routes here
    }

    log.wtf(
        "@RouteGenerator/generateRoute Error  : Route not defined => (${settings.name})");
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Scaffold(
        body: Container(
          color: Colors.red,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "Route Error : Route not defined",
              style: myStyle(12, true, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigate to a new route without replacing the current route. No context required
  /// [routeName] is the name of the route to navigate to
  /// [arguments] is the arguments to pass to the route
  navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  /// Remove the current route from stack
  /// [value] is the value to return to the previous route
  pop(value) {
    return navigatorKey.currentState?.pop(value);
  }

  /// Remove the current route from stack without returning a value
  goBack() {
    return navigatorKey.currentState?.pop();
  }

  /// Remove all routes from stack until the [desiredRoute] is reached
  popUntil(String desiredRoute) {
    return navigatorKey.currentState?.popUntil((route) {
      return route.settings.name == desiredRoute;
    });
  }

  pushNamedAndRemoveUntil(route, popToInitial) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> route) => popToInitial,
    );
  }

  /// Navigate to a new route replacing the current route. No context required
  /// [desiredRoute] is the name of the route to navigate to
  /// [arguments] is the arguments to pass to the route
  pushReplacementNamed(String desiredRoute, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(desiredRoute, arguments: arguments);
  }

  /// Get the current context anywhere you want
  BuildContext getNavigationContext() {
    return navigatorKey.currentState!.context;
  }
}

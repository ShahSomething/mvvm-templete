import 'package:flutter/material.dart';
import 'package:mvvm_template/core/others/base_view_model.dart';
import 'package:mvvm_template/core/services/navigation_service.dart';
import 'package:mvvm_template/core/services/user_data_service.dart';
import 'package:mvvm_template/locator.dart';

class NavigationScreenViewModel extends BaseViewModel {
  NavigationScreenViewModel() {
    if (!locator.isRegistered<UserDataService>()) {
      locator.registerSingleton<UserDataService>(
        UserDataService(),
        dispose: (param) {
          param.dispose();
        },
      );
    }
    initState();
  }

  final NavigationService _navigationService = locator<NavigationService>();

  void initState() {
    final userDataService = locator<UserDataService>();
    userDataService.initUserData();
  }

  List<Widget> allScreen = [
    // AppDrawer(child: DashboardScreen()),
    // MyCardScreen(),
    // CategoryScreen(enableBackButton: false),
    // ProfileScreen()
  ];
  int selectedScreen = 0;

  bool isEnableBottomBar = true;

  updatedScreenIndex(int index) {
    selectedScreen = index;
    notifyListeners();
  }

  updateBottomBarStatus(bool val) {
    isEnableBottomBar = val;
    notifyListeners();
  }

  goBack(dynamic value) {
    _navigationService.pop(value);
  }
}

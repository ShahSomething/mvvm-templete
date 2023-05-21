import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_template/core/constants/constants.dart';
import 'package:mvvm_template/core/constants/my_utils.dart';
import 'package:mvvm_template/core/theme/app_colors.dart';
import 'package:mvvm_template/ui/custom_widgets/bottom_nav_bar/fab_bar.dart';
import 'package:mvvm_template/ui/custom_widgets/image_container.dart';
import 'package:mvvm_template/ui/screens/navigation/navigation_view_model.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => NavigationScreenViewModel(),
        child: Consumer<NavigationScreenViewModel>(
          builder: (context, model, child) => WillPopScope(
            onWillPop: () async {
              final status = await MyUtils.myShowDialog(AlertDialog(
                title: const Text('Caution!'),
                content:
                    const Text('Do you really want to close the application?'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      model.goBack(true);
                    },
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      model.goBack(false);
                    },
                    child: const Text('No'),
                  ),
                ],
              ));

              /// In case user has chosen not to be kept logged in,
              /// he will get logged out of the app on exit.
              // if (status && !locator<AuthService>().isRememberMe) {
              //   await locator<AuthService>().logout();
              // }
              return status;
            },
            child: Scaffold(
              extendBody: true,
              body: model.allScreen[model.selectedScreen],

              bottomNavigationBar: model.isEnableBottomBar
                  ? FABBottomAppBar(
                      color: Colors.grey,
                      backgroundColor: Colors.grey,
                      selectedColor: AppColors.primaryColor,
                      notchedShape: const CircularNotchedRectangle(),
                      onTabSelected: model.updatedScreenIndex,
                      items: [
                        FABBottomAppBarItem(
                          icon: ImageContainer(
                            height: 30.h,
                            width: 30.h,
                            assets: Constants.appIcons.bottomHomeIcon,
                            fit: BoxFit.contain,
                          ),
                        ),
                        FABBottomAppBarItem(
                          icon: ImageContainer(
                            height: 30.h,
                            width: 30.h,
                            assets: Constants.appIcons.bottomCardIcon,
                            fit: BoxFit.contain,
                          ),
                        ),
                        FABBottomAppBarItem(
                          icon: ImageContainer(
                            height: 30.h,
                            width: 30.h,
                            assets: Constants.appIcons.bottomCategoryIcon,
                            fit: BoxFit.contain,
                          ),
                        ),
                        FABBottomAppBarItem(
                          icon: ImageContainer(
                            height: 30.h,
                            width: 30.h,
                            assets: Constants.appIcons.bottomProfileIcon,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    )
                  : Container(),
//      body: _list[_page],
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: model.isEnableBottomBar
                  ? FloatingActionButton(
                      backgroundColor: AppColors.secondaryColor,
                      onPressed: () {},
                      elevation: 2.0,
                      child: const Icon(Icons.add),
                    )
                  : Container(),
            ),
          ),
        ));
  }
}

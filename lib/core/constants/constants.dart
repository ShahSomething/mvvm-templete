import 'package:flutter/material.dart';
import 'package:mvvm_template/core/constants/strings.dart';
import 'package:mvvm_template/core/theme/app_colors.dart';

class Constants {
  static Images appImages = Images();
  static AppIcons appIcons = AppIcons();
  static AppShadows appShadows = AppShadows();
}

class Images {
  final String loginBackground = '$assetsPath/images/login_bg.png';
}

class AppIcons {
  final String appLogo = '$assetsPath/icons/logo.png';
  final String overview = '$assetsPath/icons/overview.png';
  final String users = '$assetsPath/icons/users.png';
  final String caregivers = '$assetsPath/icons/caregivers.png';
  final String document = '$assetsPath/icons/document.png';
  final String dollar = '$assetsPath/icons/dollar.png';
  final String bottomHomeIcon = "$assetsPath/bottom_home_icon.png";
  final String bottomCardIcon = "${assetsPath}bottom_card_icon.png";
  final String bottomCategoryIcon = "${assetsPath}bottom_category_icon.png";
  final String bottomProfileIcon = "${assetsPath}bottom_profile_icon.png";
}

class AppShadows {
  final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: AppColors.blackColor.withOpacity(0.05),
      spreadRadius: -1,
      blurRadius: 8,
      offset: const Offset(0, 5),
    )
  ];
  final BoxShadow backButtonShadow = const BoxShadow(
    color: AppColors.greyColor,
    spreadRadius: 2,
    blurRadius: 30,
    blurStyle: BlurStyle.normal,
    offset: Offset(0, 2),
  );

  final BoxShadow inputFieldShadow = const BoxShadow(
    color: AppColors.greyColor,
    spreadRadius: 10,
    blurRadius: 30,
    blurStyle: BlurStyle.normal,
    offset: Offset(0, 2),
  );
}

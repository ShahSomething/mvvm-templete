import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_template/core/theme/app_colors.dart';

//TODO update Theme according to your figma design
class CustomTheme {
  // Define default light and dark color themes
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.light(
      background: AppColors.backgoundColor,
      brightness: Brightness.light,
      error: AppColors.errorColor,
      errorContainer: AppColors.errorColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
    ),
    scaffoldBackgroundColor: AppColors.backgoundColor,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.greyColor,
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        disabledBackgroundColor: AppColors.greyColor,
        foregroundColor: AppColors.whiteColor,
        disabledForegroundColor: AppColors.whiteColor,
        padding: EdgeInsets.symmetric(vertical: 25.sp, horizontal: 30.sp),
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    ),
    textTheme: GoogleFonts.latoTextTheme(
      TextTheme(
        headlineSmall: TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
        headlineMedium: TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        headlineLarge: TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
          fontSize: 22.sp,
        ),
        labelSmall: TextStyle(
          color: AppColors.greyColor,
          fontWeight: FontWeight.w300,
          fontSize: 10.sp,
        ),
        labelMedium: TextStyle(
          color: AppColors.greyColor,
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
        bodySmall: TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(AppColors.primaryColor),
      checkColor: MaterialStateProperty.all(AppColors.whiteColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.whiteColor,
        disabledBackgroundColor: AppColors.greyColor,
        foregroundColor: AppColors.secondaryColor,
        disabledForegroundColor: AppColors.whiteColor,
        padding: EdgeInsets.symmetric(vertical: 25.sp, horizontal: 30.sp),
        side: BorderSide(
          color: AppColors.secondaryColor,
          width: 1.sp,
        ),
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    ),
    useMaterial3: true,
  );

  // static final ThemeData darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   primarySwatch: Colors.blue,
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  // );

  // Toggle between light and dark theme
  // static ThemeData getTheme(BuildContext context) {
  //   if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
  //     return darkTheme;
  //   } else {
  //     return lightTheme;
  //   }
  // }
}

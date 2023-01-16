import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_template/core/enums/view_state.dart';
import 'package:mvvm_template/core/others/base_view_model.dart';
import 'package:mvvm_template/core/services/authentication/firebase/fire_auth.dart';
import 'package:mvvm_template/locator.dart';
import 'package:mvvm_template/ui/custom_widgets/dialogs/auth_dialog.dart';

class ForgetPasswordScreenViewModel extends BaseViewModel {
  FireAuth authService = locator<FireAuth>();
  //ResetPasswordBody resetPasswordBody = ResetPasswordBody();
  TextEditingController emailController = TextEditingController();
  //late ResetPasswordResponse response;

  resetPassword() async {
    setState(ViewState.busy);
    bool emailSent = await authService.resetPassword(emailController.text);
    if (!emailSent) {
      Get.dialog(
        const AuthDialog(
            title: 'Error', message: 'Failed to send password reset email'),
      );
    }
    setState(ViewState.idle);
    Get.back();
  }
}

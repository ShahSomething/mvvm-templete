import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_template/core/enums/view_state.dart';
import 'package:mvvm_template/core/models/user/profile.dart';
import 'package:mvvm_template/core/others/base_view_model.dart';
import 'package:mvvm_template/core/services/authentication/firebase/fire_auth.dart';
import 'package:mvvm_template/core/services/database/firestore/firebase_db_service.dart';
import 'package:mvvm_template/core/services/file_picker_service.dart';
import 'package:mvvm_template/locator.dart';
import 'package:mvvm_template/ui/custom_widgets/dialogs/auth_dialog.dart';
import 'package:mvvm_template/ui/screens/navigation/navigation_screen.dart';

class SignUpViewModel extends BaseViewModel {
  final FireAuth _authService = locator<FireAuth>();
  final FirebaseService _dbService = locator<FirebaseService>();
  final FilePickerService _imagePickerService = locator<FilePickerService>();
  int? selectedGenderIndex;
  UserProfile userProfile = UserProfile();
  File? image;
  //SignUpBody signUpBody = SignUpBody();
  //late AuthResponse response;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool passwordVisibility = true;

  togglePasswordVisibility() {
    setState(ViewState.busy);
    passwordVisibility = !passwordVisibility;
    setState(ViewState.idle);
  }

  updateIndex(val) {
    selectedGenderIndex = val;
    notifyListeners();
  }

  requestSignUp() async {
    setState(ViewState.busy);
    User? user = await _authService.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    if (user == null) {
      Get.dialog(
        const AuthDialog(
            title: 'Error', message: 'Failed to create new account'),
      );
    } else {
      userProfile.gender = selectedGenderIndex == 0 ? "Male" : "Female";
      String uid = await _dbService.uploadUserData(userProfile);
      if (image != null) {
        String imgUrl =
            await _dbService.uploadFile(image!, 'Users/Profiles/$uid');
        _dbService.updateUserInfo(
          uid,
          {
            'imageUrl': imgUrl,
          },
        );
      }

      Get.offAll(const NavigationScreen());
    }
    setState(ViewState.idle);
  }

  pickImage() async {
    image = await _imagePickerService.pickImage();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mvvm_template/core/constants/my_utils.dart';
import 'package:mvvm_template/core/enums/view_state.dart';
import 'package:mvvm_template/ui/custom_widgets/gender_radio_group.dart';
import 'package:mvvm_template/ui/custom_widgets/image_container.dart';
import 'package:mvvm_template/ui/custom_widgets/text_fields/custom_text_field.dart';
import 'package:mvvm_template/ui/screens/authentication/signup_screen/signup_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: SafeArea(
            child: Scaffold(
              // backgroundColor: backgroundColor,
              body: Stack(
                children: [
                  Container(
                      // color: greyColor,
                      ),

                  ///
                  /// Column Contain app Bar And  User profile Image
                  ///
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ///
                        /// ========== This Section Contain Back Button And Avatar =============
                        ///
                        Container(
                          decoration: BoxDecoration(
                              // color: backgroundColor,
                              border: Border.all(
                                  color: Colors.transparent, width: 0.0)),
                          child: Column(
                            children: [
                              const SizedBox(height: 60),

                              ///
                              /// custom app bar
                              ///
                              // AuthenticationAppBar(
                              //   heading: "Sign Up",
                              // ),

                              ///
                              /// UserIcon
                              ///
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 60, bottom: 24),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      /// User profile Avatar
                                      if (model.image != null)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: Image.file(
                                            model.image!,
                                            height: 141,
                                            width: 141,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      else
                                        const ImageContainer(
                                          height: 141,
                                          width: 141,
                                          assets:
                                              "assets/static_assets/avatar.png",
                                          radius: 0,
                                        ),

                                      /// Add Image Icon
                                      Positioned(
                                        right: 05,
                                        top: 02,
                                        child: InkWell(
                                          onTap: () {
                                            debugPrint(
                                                'Pick Image button Clicked');
                                            model.pickImage();
                                          },
                                          child: Container(
                                            height: 30.h,
                                            width: 30.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF2E0A9),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///
                        /// =============== This Section Contain Login Form ==============
                        ///
                        Stack(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  // color: backgroundColor,
                                  border: Border.all(
                                      color: Colors.transparent, width: 0.0)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 31),
                              decoration: const BoxDecoration(
                                  // color: greyColor,
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                topLeft: Radius.circular(24),
                              )),
                              child: Form(
                                key: _formKey,
                                child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    /// Contain Facebook, google, apple sign Button
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // SocialAuthButtons(),
                                      ],
                                    ),

                                    const SizedBox(height: 23),

                                    /// user name field
                                    CustomTextField(
                                      controller: model.userNameController,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please enter your user name';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTap: () {},
                                      onSaved: (val) {
                                        model.userProfile.name = val;
                                      },
                                      hintText: "Username",
                                    ),

                                    20.verticalSpace,

                                    /// Password field
                                    CustomTextField(
                                      controller: model.passwordController,
                                      obscure: model.passwordVisibility,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Please enter your password';
                                        } else if (val.length < 8) {
                                          return 'password must include 8 characters';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTap: () {},
                                      onSaved: (val) {
                                        // model.userProfile.password = val;
                                      },
                                      hintText: "Password",
                                      suffix: IconButton(
                                        icon: Icon(
                                          model.passwordVisibility
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          size: 18.h,
                                          color: const Color(0xFFB1B1B1),
                                        ),
                                        onPressed: () {
                                          model.togglePasswordVisibility();
                                        },
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    /// Email field
                                    CustomTextField(
                                      controller: model.emailController,
                                      validator: (val) {
                                        if (!MyUtils.isEmail(
                                            val.toString().trim())) {
                                          return 'Please Enter a Valid Email';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTap: () {},
                                      onSaved: (val) {
                                        model.userProfile.email = val;
                                      },
                                      hintText: "Email",
                                    ),

                                    20.verticalSpace,

                                    /// location field
                                    CustomTextField(
                                      controller: model.locationController,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please enter your location';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTap: () {},
                                      onSaved: (val) {
                                        model.userProfile.location = val;
                                      },
                                      hintText: "Location",
                                    ),

                                    16.verticalSpace,

                                    /// Row Contain Is Remind radio button
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 21, 0, 41),
                                      child: GenderRadioGroup(model),
                                    ),

                                    // Container(
                                    //   width: 147.w,
                                    //   height: 45.h,
                                    //   child: RectangularButton(
                                    //     radius: 15,
                                    //     text: "Sign Up",
                                    //     onPressed: () async {
                                    //       if (_formKey.currentState!
                                    //           .validate()) {
                                    //         _formKey.currentState!.save();
                                    //         model.requestSignUp();
                                    //       }
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

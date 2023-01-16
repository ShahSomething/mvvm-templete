import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvvm_template/core/enums/view_state.dart';
import 'package:mvvm_template/ui/custom_widgets/text_fields/custom_text_field.dart';
import 'package:mvvm_template/ui/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:mvvm_template/ui/screens/authentication/login_screen/login_view_model.dart';
import 'package:mvvm_template/ui/screens/authentication/signup_screen/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
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
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.white, width: 0.0)),
                          child: Column(
                            children: const [
                              SizedBox(height: 60),

                              ///
                              /// UserIcon
                              ///
                              Padding(
                                padding: EdgeInsets.only(top: 60, bottom: 24),
                                child: Center(
                                    child: FlutterLogo(
                                  size: 100,
                                )
                                    //  ImageContainer(
                                    //   height: 141,
                                    //   width: 141,
                                    //   assets: "assets/static_assets/avatar.png",
                                    //   radius: 0,
                                    // ),
                                    ),
                              ),
                            ],
                          ),
                        ),

                        ///
                        /// ========= Login Form Section =========
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        // SocialAuthButtons(),
                                      ],
                                    ),

                                    const SizedBox(height: 23),

                                    ///
                                    /// user name field
                                    ///
                                    CustomTextField(
                                        controller: model.emailController,
                                        onTap: () {},
                                        validator: (val) {
                                          if (!val.toString().trim().isEmail) {
                                            return 'Please Enter a Valid Email';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (val) {
                                          //model.loginBody.email = val;
                                        },
                                        hintText: "Username",
                                        prefixIcon: const Icon(Icons.person)
                                        //  ImageContainer(
                                        //   width: 22.w,
                                        //   height: 22.h,
                                        //   assets:
                                        //       "${staticAssetsPath}user_field_icon.png",
                                        //   fit: BoxFit.contain,
                                        // ),
                                        ),

                                    const SizedBox(height: 24),

                                    ///
                                    /// Password field
                                    ///
                                    CustomTextField(
                                        obscure: model.passwordVisibility,
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Please enter your password';
                                          } else if (val.length < 8) {
                                            return 'Password must include 8 characters';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: model.passwordController,
                                        onTap: () {},
                                        onSaved: (val) {
                                          //model.loginBody.password = val;
                                        },
                                        hintText: "Password",
                                        suffixIcon: IconButton(
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
                                        prefixIcon: const Icon(Icons.password)
                                        // ImageContainer(
                                        //   width: 22.w,
                                        //   height: 22.h,
                                        //   assets:
                                        //       "${staticAssetsPath}pasword_field_icon.png",
                                        //   fit: BoxFit.contain,
                                        // ),
                                        ),

                                    const SizedBox(height: 16),

                                    ///
                                    /// Remember me radio buttons section
                                    ///
                                    Row(
                                      children: [
                                        // CustomSingleRadioButton(
                                        //   isSelected: model.isRememberMe,
                                        //   onPressed: {
                                        //     model.toggleIsRememberMe()
                                        //   },
                                        // ),
                                        // InkWell(
                                        //   onTap: () =>
                                        //       ,
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.all(8.0),
                                        //     child: CustomSingleRadioButton(

                                        //     ),
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   width: 6,
                                        // ),
                                        // Text(
                                        //   "Remember Me",
                                        //   style:
                                        //       textStyleWithHacenFont.copyWith(
                                        //           fontSize: 11,
                                        //           color: Colors.white),
                                        // ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                                const ForgetPasswordScreen());
                                          },
                                          child: const Text(
                                            "Forget Password",
                                            // style:
                                            //     textStyleWithHacenFont.copyWith(
                                            //   fontSize: 11,
                                            //   decoration:
                                            //       TextDecoration.underline,
                                            // ),
                                          ),
                                        )
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    ///
                                    /// Register Button
                                    ///
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(SignUpScreen());
                                        },
                                        child: const Text(
                                          "Register",
                                          // style:
                                          //     textStyleWithHacenFont.copyWith(
                                          //   fontSize: 11,
                                          //   decoration:
                                          //       TextDecoration.underline,
                                          // ),
                                        ),
                                      ),
                                    ),

//                                     Container(
//                                       width: 147.w,
// //                                    height: 45.h,
//                                       padding: EdgeInsets.only(top: 100),
//                                       child: RectangularButton(
//                                           height: 45.h,
//                                           radius: 14,
//                                           text: "Login",
//                                           onPressed: () async {
//                                             if (_formKey.currentState!
//                                                 .validate()) {
//                                               _formKey.currentState!.save();
//                                               await model.requestLogin();
//                                               if (!model.response.success) {
//                                                 Get.dialog(
//                                                   AlertDialog(
//                                                     title: Text("Failed"),
//                                                     content: Text(
//                                                         "${model.response.error}"),
//                                                     actions: [
//                                                       ElevatedButton(
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child: Text("Ok"),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               } else {
//                                                 Get.offAll(AppDrawer(
//                                                   child: RootScreen(),
//                                                 ));
//                                               }
//                                             }
// //                                        Get.offAll(AppDrawer(
// //                                          child: RootScreen(),
// //                                        ));
//                                           }),
//                                     ),
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

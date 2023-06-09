// ignore_for_file: body_might_complete_normally_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:mvvm_template/core/constants/my_utils.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_logger.dart';
import 'package:mvvm_template/core/services/database/firestore/firebase_db_service.dart';
import 'package:mvvm_template/locator.dart';

/// [FireAuth] class contains all authentication related logic with following
/// methods:
///
/// [_updateFcmToken]: This method updates the fcm token for current user
/// whenever they sign up or log in
///
/// [createUserWithEmailAndPassword]: This method is used for signup with email and password.
///
/// [signInWithEmailAndPassword]: This method is used for signin with email and password.
///
/// [sendEmailVerification]: This method can be used to send email verification code for current user
///
/// [isEmailVerified]: This method checks if the email of current user is verified
///
/// [signOut]: This method is used for signing out the current user.
///
/// [resetPassword]: This method is used for resetting the current user's password
///
/// [deleteAccount]: This method is used for deleting the account and info of current user
class FireAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? fcmToken;
  // UserProfile? userProfile;
  final Logger log = CustomLogger(className: 'FireAuth');

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  User? get currentUser => _firebaseAuth.currentUser;

  final _dbService = locator<FirebaseService>();

  /// Updates the fcm token
  _updateFcmToken() async {
    // final fcmToken = await locator<NotificationsService>().getFcmToken();
    //final deviceId = await DeviceInfoService().getDeviceId();
    await _dbService.updateFCMToken(currentUser!.uid, fcmToken!);
  }

  ///Signs out the current user.
  Future<void> signOut() async {
    _dbService.updateFCMToken(currentUser!.uid, null);
    return _firebaseAuth.signOut();
  }

  /// Tries to create a new user account with the given email address and password.
  ///
  /// Other parameters include:
  ///   1) sendVarificationMail: set this to [true] if you want to send an email verification code to user
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
    bool sendVarificationMail = false,
  }) async {
    User? user;
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        //await _updateFcmToken();
        await user.reload();
      }
      user = _firebaseAuth.currentUser;
      if (sendVarificationMail) {
        try {
          await user?.sendEmailVerification();
        } catch (e) {
          MyUtils.showErrorSnackBar('Auth Error', e.toString());
          log.e("@createUserWithEmailAndPassword: $e");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        MyUtils.showErrorSnackBar('Auth Error', "Weak Password");
        log.e('@createUserWithEmailAndPassword: Weak Password');
      } else if (e.code == 'email-already-in-use') {
        MyUtils.showErrorSnackBar('Auth Error', "Email already in use");
        log.e('@createUserWithEmailAndPassword: Email already in use');
      }
      return null;
    } catch (e) {
      MyUtils.showErrorSnackBar('Auth Error', e.toString());
      log.e("@createUserWithEmailAndPassword: $e");
      return null;
    }
    return user;
  }

  /// Attempts to sign in a user with the given email address and password.
  ///
  /// **Important**: You must enable Email & Password accounts in the Auth
  /// section of the Firebase console before being able to use them.
  ///
  /// Other parameters include:
  ///   1) checkIfEmailIsVerified: set this to [true] if you want to check if the user
  /// email is verified before signing them in
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
    bool checkIfEmailIsVerified = false,
  }) async {
    User? user;
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      _updateFcmToken();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        MyUtils.showErrorSnackBar('Auth Error', "User not found");
        log.e("@signInWithEmailAndPassword: User not found");
      } else if (e.code == 'wrong-password') {
        MyUtils.showErrorSnackBar('Auth Error', "Wrong Password");
        log.e("@signInWithEmailAndPassword: Wrong password");
      } else {
        MyUtils.showErrorSnackBar('Auth Error', e.toString());
        log.wtf("@signInWithEmailAndPassword: the exception is $e");
      }
    }
    if (user != null) {
      if ((!checkIfEmailIsVerified) || user.emailVerified) {
        return user;
      } else {
        MyUtils.showErrorSnackBar(
            'Auth Error', "Account not verified through e-mail");
        log.i(
            '@signInWithEmailAndPassword: Account not verified through e-mail');
        return null;
      }
    }
    return null;
  }

  ///Sends a verification email to the current user
  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    user?.sendEmailVerification();
  }

  /// Checks if the email of current user is verified
  Future<bool> isEmailVerified() async {
    User? user = _firebaseAuth.currentUser;
    return user?.emailVerified ?? false;
  }

  /// Sends a password reset email to the given email address.
  ///
  /// To complete the password reset, call [confirmPasswordReset] with the code supplied in the email sent to the user, along with the new password specified by the user.
  Future<bool> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'auth/invalid-email':
          MyUtils.showErrorSnackBar('Auth Error', "Invalid Email");
          log.i('@resetPassword: Invalid Email');
          break;
        case 'auth/user-not-found':
          MyUtils.showErrorSnackBar('Auth Error', "User not found");
          log.i('@resetPassword: User not found');
          break;
      }
      return false;
    }
  }

  /// Deletes and signs out the user.
  ///
  /// **Important**: this is a security-sensitive operation that requires the
  /// user to have recently signed in.
  Future<bool> deleteAccount(String password) async {
    var currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      final credential = EmailAuthProvider.credential(
          email: currentUser.email!, password: password.trim());
      try {
        await currentUser.reauthenticateWithCredential(credential);
      } catch (err) {
        MyUtils.showErrorSnackBar('Auth Error', err.toString());
        log.e('@deleteAccount Error: $err');
        return false;
      }
      _dbService.deleteUserData(currentUser.uid);
      currentUser.delete();
      return true;
    }
    return false;
  }

  /// Changes the password for current User.
  ///
  /// **Important**: this is a security-sensitive operation that requires the
  /// user to have recently signed in.
  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    try {
      final credential = EmailAuthProvider.credential(
          email: currentUser!.email!, password: currentPassword);
      await currentUser!
          .reauthenticateWithCredential(credential)
          .catchError((err) {
        throw err;
      });
      await currentUser!.updatePassword(newPassword);
      // Password update successful, show success message and reset form
      return true;
    } catch (error) {
      // Password update failed, show error message
      if (error is FirebaseAuthException) {
        if (error.code == 'weak-password') {
          // Show error message for weak password
          MyUtils.showErrorSnackBar(
            'Weak Password',
            'Please enter a strong password',
          );
        } else if (error.code == 'wrong-password') {
          // Show error message for incorrect current password
          MyUtils.showErrorSnackBar(
            'Incorrect Password',
            'Please enter correct password',
          );
        } else {
          // Show generic error message
          MyUtils.showErrorSnackBar(
            'Error',
            error.toString(),
          );
        }
      }
    }
    return false;
  }

  //TODO implement signIn with Google

  //TODO implement signIn with Facebook

  //TODO implement signIn with Apple

  //TODO implement signIn with Instagram

  //TODO implement signIn with Twitter

  //TODO implement signIn with Phone Number
}

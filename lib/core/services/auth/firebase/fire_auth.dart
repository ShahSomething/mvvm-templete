import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_logger.dart';
import 'package:mvvm_template/core/services/device_info_service.dart';
import 'package:mvvm_template/core/services/notification_service.dart';
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

  /// Updates the fcm token
  _updateFcmToken() async {
    final fcmToken = await locator<NotificationsService>().getFcmToken();
    final deviceId = await DeviceInfoService().getDeviceId();
    //TODO update fcm in database
  }

  ///Signs out the current user.
  Future<void> signOut() async {
    //TODO clear fcm token
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
        await _updateFcmToken();
        await user.reload();
      }
      user = _firebaseAuth.currentUser;
      if (sendVarificationMail) {
        try {
          await user?.sendEmailVerification();
        } catch (e) {
          log.e("the exception is $e");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log.e('Weak Password');
      } else if (e.code == 'email-already-in-use') {
        log.e('Email already in use');
      }
    } catch (e) {
      log.e("the exception is $e");
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
        log.e("User not found");
      } else if (e.code == 'wrong-password') {
        log.e("Wrong password");
      } else {
        log.wtf("the exception is $e");
      }
    }
    if (user != null) {
      if (checkIfEmailIsVerified && user.emailVerified) {
        return user;
      } else {
        log.i('Account not verified through e-mail');
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
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// Deletes and signs out the user.
  ///
  /// **Important**: this is a security-sensitive operation that requires the
  /// user to have recently signed in.
  Future<void> deleteAccount(String password) async {
    var currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      final credential = EmailAuthProvider.credential(
          email: currentUser.email!, password: password);
      await currentUser
          .reauthenticateWithCredential(credential)
          .catchError((err) {
        log.e('@deleteAccount Error: $err');
      });
      //TODO delete data from database
      currentUser.delete();
    }
  }

  //TODO implement signIn with Google

  //TODO implement signIn with Facebook

  //TODO implement signIn with Apple

  //TODO implement signIn with Instagram

  //TODO implement signIn with Twitter

  //TODO implement signIn with Phone Number

}

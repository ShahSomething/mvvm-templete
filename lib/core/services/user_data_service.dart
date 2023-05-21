import 'dart:async';

import 'package:mvvm_template/core/models/user/profile.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_logger.dart';
import 'package:mvvm_template/core/services/authentication/firebase/fire_auth.dart';
import 'package:mvvm_template/core/services/database/firestore/firebase_db_service.dart';
import 'package:mvvm_template/locator.dart';

///This class contains all the data that can be accessed from anywhere in the app
class UserDataService {
  //Required services
  final logger = CustomLogger(className: 'UserDataService');
  final _dbService = locator<FirebaseService>();
  final _authService = locator<FireAuth>();

  //Variables to store user data
  UserProfile? userProfile;

  var firstTime =
      true; //This variables is used to listen to the streams only one time

  //Stream Controllers
  final StreamController<UserProfile> _userProfileStreamController =
      StreamController.broadcast();

  //Stream Getters
  Stream<UserProfile> get userProfileStream =>
      _userProfileStreamController.stream;

  //Stream Subscriptions
  StreamSubscription<UserProfile>? _userProfileStreamSubscription;

  //Variable to indicate which data is loading
  bool userProfileIsLoading = true;

  initUserData() async {
    logger.i('@initUserData:  Initialising user data');
    if (firstTime) {
      //Initialize all the streams
      _userProfileStreamController.addStream(
        _dbService.getUserDataStream(_authService.currentUser!.uid),
      );

      //Listen to the streams and update the variables
      _userProfileStreamSubscription = userProfileStream.listen((event) {
        userProfile = event;
        userProfileIsLoading = false;
      });

      firstTime = false;
    }
  }

  //Dispose all the streams
  dispose() {
    _userProfileStreamSubscription?.cancel();
  }
}

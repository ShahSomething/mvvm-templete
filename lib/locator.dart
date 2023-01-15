import 'package:get_it/get_it.dart';
import 'package:mvvm_template/core/config/config.dart';
import 'package:mvvm_template/core/enums/env.dart';
import 'package:mvvm_template/core/services/api_services.dart';
import 'package:mvvm_template/core/services/authentication/custom%20backend/auth_service.dart';
import 'package:mvvm_template/core/services/authentication/firebase/fire_auth.dart';
import 'package:mvvm_template/core/services/database/custom%20backend/database_service.dart';
import 'package:mvvm_template/core/services/database/firestore/firebase_db_service.dart';
import 'package:mvvm_template/core/services/file_picker_service.dart';
import 'package:mvvm_template/core/services/local_storage_service.dart';
import 'package:mvvm_template/core/services/notification_service.dart';

GetIt locator = GetIt.instance;

setupLocator(Env env) async {
  //TODO comment the dependencies which are not required

  //The ordering of putting the dependencies matter here
  //For example if Auth service is using some function of
  //Database service then Database service needs to be put
  //before the Auth service.
  locator.registerSingleton(Config(env));
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton(NotificationsService());
  locator.registerSingleton<ApiServices>(ApiServices());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerLazySingleton<FirebaseService>(() => FirebaseService());
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<FireAuth>(FireAuth());
  locator.registerLazySingleton(() => FilePickerService());
}

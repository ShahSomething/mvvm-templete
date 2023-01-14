import 'package:get_it/get_it.dart';
import 'package:mvvm_template/core/config/config.dart';
import 'package:mvvm_template/core/enums/env.dart';
import 'package:mvvm_template/core/services/api_services.dart';
import 'package:mvvm_template/core/services/auth_service.dart';
import 'package:mvvm_template/core/services/database_service.dart';
import 'package:mvvm_template/core/services/file_picker_service.dart';
import 'package:mvvm_template/core/services/local_storage_service.dart';
import 'package:mvvm_template/core/services/notification_service.dart';

GetIt locator = GetIt.instance;

setupLocator(Env env) async {
  locator.registerSingleton(Config(env));
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton(NotificationsService());
  locator.registerSingleton<ApiServices>(ApiServices());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerLazySingleton(() => FilePickerService());
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_template/app.dart';
import 'package:mvvm_template/core/enums/env.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_logger.dart';
import 'package:mvvm_template/firebase_options.dart';
import 'package:mvvm_template/locator.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  final log = CustomLogger(className: 'main');
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await setupLocator(Env.production);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(const MyApp(title: 'App Name'));
  } catch (e) {
    log.e("$e");
  }
}

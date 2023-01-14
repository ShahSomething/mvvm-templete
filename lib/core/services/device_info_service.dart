import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfoService {
  final deviceInfo = DeviceInfoPlugin();
  Future<String> getDeviceId() async {
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}

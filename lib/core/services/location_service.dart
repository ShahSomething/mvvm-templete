import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_logger.dart';
// import 'package:mvvm_template/core/services/navigation_service.dart';
// import 'package:mvvm_template/locator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Position? currentLocation;
  double? latitude;
  double? longitude;
  final Logger log = CustomLogger(className: 'LocationService');
  //final NavigationService _navigationScreen = locator<NavigationService>();

  ///returns [Position] for the current location
  Future<Position?> getCurrentLocation() async {
    currentLocation = await Geolocator.getCurrentPosition();
    if (currentLocation == null) {
      await checkPermissionStatus();
      //await checkGpsService();
    }
    log.d(
        'Latitude: ${currentLocation!.latitude}, Longitude: ${currentLocation!.longitude}');
    return currentLocation;
  }

  ///checks the location permission and requests permission if not granted
  checkPermissionStatus() async {
    LocationPermission permission = await checkPermissionStatus();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Permission.location.request();
    }
  }

  // checkGpsService() async {
  //   if (await Geolocator.isLocationServiceEnabled()) {
  //     Get.defaultDialog(
  //         title: 'GPS is Disabled',
  //         middleText: 'Please turn on your GPS Location',
  //         textConfirm: 'TURN ON',
  //         onConfirm: () async {
  //           await Geolocator.openLocationSettings();
  //           Get.back();
  //         },
  //         textCancel: 'Skip',
  //         onCancel: () {});
  //   }
  // }

  ///returns the address for the provided [LatLng]
  Future<String> getAddressFromLatLng(LatLng? location) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          location!.latitude, location.longitude);

      Placemark place = placeMarks[0];
      log.d("the location is  ${place.thoroughfare} "
          " ${place.subLocality}"
          " ${place.locality}"
          " ${place.country}");
      return "${place.thoroughfare} ${place.subLocality} ${place.locality} ${place.country}";
    } catch (e) {
      log.d("the exception is $e");
      return '';
    }
  }
}

import 'package:geolocator/geolocator.dart';

class LocationServices {
  // Permission Handling
  Future<bool> checkLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return await requestLocationPermission();
    }
    return true;
  }

  Future<bool> requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  // Location Handling
  Future<Position?> getCurrentLocation() async {
    final permission = await checkLocationPermission();
    if (permission) {
      return await Geolocator.getCurrentPosition();
    }
    return null;
  }
}

import 'package:geolocator/geolocator.dart';

class CheckLocationPermession {
  Future<Position> initLocation() async {
    return await determineLocation();
  }

  Future<Position> determineLocation() async {
    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        await Geolocator.openLocationSettings();

        isServiceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!isServiceEnabled) {
          throw Exception('Location services are still disabled.');
        }
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        throw Exception("Please enable location manually then reopen the app.");
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}

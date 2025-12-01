import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' hide LocationAccuracy;

class LocationFailure implements Exception {
  final String message;
  LocationFailure(this.message);

  @override
  String toString() => message;
}

class LocationService {
  final Location location = Location();
  Future<Position> getLocation() async {
    try {
      // 1. Check service
      if (!await Geolocator.isLocationServiceEnabled()) {
        try {
          var isServiceEnable = await location.serviceEnabled();
          if (!isServiceEnable) {
            isServiceEnable = await location.requestService();
          }
          LocationFailure("check The internet");
        } catch (e) {
          LocationFailure('Error checking/requesting location service: $e');
        }
      }

      // 2. Check permissions
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationFailure("Location permission was denied.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        throw LocationFailure(
          "Location permission is permanently denied. "
          "Please enable it from settings.",
        );
      }

      // 3. Get Position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      throw LocationFailure("Failed to get location: $e");
    }
  }
}

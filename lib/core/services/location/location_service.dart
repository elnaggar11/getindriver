import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocatorService {
  static final LocatorService _instance = LocatorService._internal();
  factory LocatorService() => _instance;
  LocatorService._internal();

  Future<bool> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await checkLocationPermission();
      if (!hasPermission) {
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return position;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  static (LatLng point, double distance, int index) getNearestPointOnPolyline(
    LatLng current,
    List<LatLng> polyline,
  ) {
    if (polyline.length < 2) {
      throw Exception("Polyline must have at least 2 points");
    }

    LatLng nearestPoint = polyline.first;
    double nearestDistance = double.infinity;
    int index = 0;
    for (int i = 0; i < polyline.length - 1; i++) {
      LatLng p1 = polyline[i];
      LatLng p2 = polyline[i + 1];

      LatLng projection = _projectPointOnSegment(current, p1, p2);

      double distance = Geolocator.distanceBetween(
        current.latitude,
        current.longitude,
        projection.latitude,
        projection.longitude,
      );

      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearestPoint = projection;
        index = i;
      }
    }

    return (nearestPoint, nearestDistance, index);
  }

  /// Projects point p onto the line segment [v, w]
  static LatLng _projectPointOnSegment(LatLng p, LatLng v, LatLng w) {
    double px = p.latitude, py = p.longitude;
    double vx = v.latitude, vy = v.longitude;
    double wx = w.latitude, wy = w.longitude;

    double dx = wx - vx;
    double dy = wy - vy;

    if (dx == 0 && dy == 0) return v; // segment is a point

    double t = ((px - vx) * dx + (py - vy) * dy) / (dx * dx + dy * dy);

    if (t < 0) {
      t = 0;
    } else if (t > 1)
      t = 1;

    return LatLng(vx + t * dx, vy + t * dy);
  }
}

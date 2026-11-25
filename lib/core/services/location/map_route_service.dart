import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RouteService {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
  static const String _apiKey =
      'AIzaSyDIKS4q1KAy8ihwmtjMbBpEc-c7M2RxmNg'; // Replace with your API key

  final Dio _dio = Dio()
    ..interceptors.addAll(
      (!kReleaseMode)
          ? [
              PrettyDioLogger(
                requestHeader: true,
                requestBody: true,
                responseBody: true,
                error: true,
                compact: true,
                maxWidth: 90,
              ),
            ]
          : [],
    );

  Future<List<LatLng>?> getRoute(LatLng origin, LatLng destination) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': _apiKey,
          'mode': 'driving',
          'alternatives': 'false',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final polylinePoints = route['overview_polyline']['points'];

          return _decodePolyline(polylinePoints);
        } else {
          print('Directions API error: ${data['status']}');
          return null;
        }
      } else {
        print('HTTP error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching route: $e');
      return null;
    }
  }

  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> coordinates = [];
    int index = 0;
    int len = polyline.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      coordinates.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return coordinates;
  }

  Future<Map<String, dynamic>?> getRouteDetails(
    LatLng origin,
    LatLng destination,
  ) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': _apiKey,
          'mode': 'driving',
          'alternatives': 'false',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final leg = route['legs'][0];

          return {
            'distance': leg['distance']['text'],
            'duration': leg['duration']['text'],
            'polylinePoints': _decodePolyline(
              route['overview_polyline']['points'],
            ),
          };
        }
      }
      return null;
    } catch (e) {
      print('Error fetching route details: $e');
      return null;
    }
  }
}

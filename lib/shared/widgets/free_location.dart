import 'package:getin_driver/core/localization/localization_helper.dart';
/* import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:getin_driver/core/services/alerts.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/shared/widgets/customtext.dart';
import 'package:latlong2/latlong.dart' as LL;

class FreeLocationPickerScreen extends StatefulWidget {
  const FreeLocationPickerScreen({super.key, this.initPoint});
  final LL.LatLng? initPoint;

  @override
  State<FreeLocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<FreeLocationPickerScreen> {
  Position? _currentPosition;
  String? _currentAddress;
  LL.LatLng? _lastMapPosition;
  final MapController _mapController = MapController();
  @override
  void initState() {
    if (widget.initPoint != null) {
      _lastMapPosition = LL.LatLng(
        widget.initPoint!.latitude,
        widget.initPoint!.longitude,
      );
    }
    super.initState();
  }

  List<Placemark> placemarks = [];
  _getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });
    _mapController.move(
      LL.LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      15.0, // Zoom level
    );
  }

  void _confirmLocation() {
    if (_lastMapPosition != null) {
      Navigator.pop(context, [
        LL.LatLng(_lastMapPosition!.latitude, _lastMapPosition!.longitude),
        //  {'latitude': _selectedLocation!.latitude, 'longitude': _selectedLocation!.longitude},
        _currentAddress,
      ]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText(LocalizationHelper.tr.select_location_first_message.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(LocalizationHelper.tr.select_your_location)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: null,
            heroTag: null,
            onPressed: () async {
              await _getCurrentLocation();
              if (_currentPosition != null) {
                _lastMapPosition = LL.LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                );

                setState(() {});
              }
            },
            tooltip: LocalizationHelper.tr.current_location,
            child: const Icon(Icons.location_on),
          ),
          8.ph,
          FloatingActionButton(
            key: null,
            heroTag: null,
            onPressed: () async {
              if (_lastMapPosition == null) {
                Alerts.snack(
                  text: LocalizationHelper.tr.select_location_first,
                  state: SnackState.failed,
                );
                return;
              }
              placemarks = await placemarkFromCoordinates(
                _lastMapPosition!.latitude,
                _lastMapPosition!.longitude,
              );
              if (placemarks.isEmpty) {
                Alerts.snack(
                  text: LocalizationHelper.tr.select_another_location,
                  state: SnackState.failed,
                );
                return;
              }
              log(placemarks[0].toString(), name: "placeMark");
              Navigator.pop(context, [_lastMapPosition, placemarks]);
            },
            tooltip: LocalizationHelper.tr.pick_location,
            child: const Icon(Icons.flag),
            //  CustomText(LocalizationHelper.tr.pick_location ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter:
                    toLatLngs(_currentPosition) ??
                    const LL.LatLng(24.7136, 46.6753),
                minZoom: 2.0,
                maxZoom: 18,
                initialZoom: 8,
                onTap: (tapPosition, point) {
                  setState(() {
                    _lastMapPosition = LL.LatLng(
                      point.latitude,
                      point.longitude,
                    );
                    _currentPosition = toPosition(point);
                  });
                  log(_lastMapPosition.toString(), name: "lastMapPosition");
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.yourapp',
                ),
                if (_currentPosition != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: toLatLngs(_currentPosition)!,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          /*    Positioned(
            bottom: 60,
            left: 16,
            right: 16,
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 60),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(LocalizationHelper.tr.select_your_location, weight: FontWeight.bold),
                  const SizedBox(height: 8),
                  FutureBuilder<List<Placemark>>(
                    future:
                        _lastMapPosition != null
                            ? placemarkFromCoordinates(
                              _lastMapPosition!.latitude,
                              _lastMapPosition!.longitude,
                            )
                            : null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        final place = snapshot.data!.first;
                        log(place.toString(), name: "place");
                        return CustomText(fullAddresse(place));
                      } else {
                        return CustomText(LocalizationHelper.tr.tap_map_to_select_location);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
       */
        ],
      ),
    );
  }

  String fullAddresse(Placemark place) {
    return [
      place.subThoroughfare,
      place.street,
      place.subLocality,
      place.locality,
      place.administrativeArea,
      place.country,
    ].map((e) => e ?? LocalizationHelper.tr.unspecified_phrase).where((e) => e.isNotEmpty).join(', ');
  }
}

Position toPosition(LL.LatLng point) {
  return Position(
    longitude: point.longitude,
    latitude: point.latitude,
    timestamp: DateTime.now(),
    accuracy: 0.1,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );
}

LL.LatLng? toLatLngs(Position? position) {
  if (position == null) {
    return null;
  }
  return LL.LatLng(position.latitude, position.longitude);
}
 */

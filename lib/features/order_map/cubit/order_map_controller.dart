import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getin_driver/features/order_map/cubit/order_map_state.dart';
import 'package:getin_driver/features/order_map/domain/repository/repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/services/location/location_service.dart';
import '../../../../core/services/location/map_route_service.dart';
import 'package:flutter/services.dart';

const double kDetourThreshold = 103; // meters

class MapCubit extends Cubit<MapState> {
  final LocatorService _locatorService;
  final RouteService _routeService;

  StreamSubscription<Position>? _positionStream;
  List<LatLng> _routePolylinePoints = [];
  final BranchMapRepository _branchMapRepository;

  MapCubit(this._locatorService, this._routeService, this._branchMapRepository)
      : super(const MapState());

  Future<void> init(LatLng destination) async {
    emit(state.copyWith(isLoading: true, destination: destination));

    final hasPerm = await _locatorService.checkLocationPermission();
    if (!hasPerm) {
      emit(
        state.copyWith(
          hasLocationPermission: false,
          markers: {
            Marker(
              markerId: const MarkerId('destination'),
              position: destination,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          },
          polylines: {},
          isLoading: false,
        ),
      );
      return;
    }

    final current = await _locatorService.getCurrentLocation();
    if (current == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    _listenToLiveLocation();
    await _drawRoute(LatLng(current.latitude, current.longitude), destination);
  }

  void _listenToLiveLocation() {
    _positionStream?.cancel();
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    ).listen((pos) {
      emit(state.copyWith(currentPosition: pos));
      _updatePolylineProgress(LatLng(pos.latitude, pos.longitude));
    });
  }

  Future<void> _drawRoute(LatLng origin, LatLng destination) async {
    emit(state.copyWith(isLoading: true));
    final updatedIcon = await _createCircleAvatarMarker(
      color: Colors.yellow,
      icon: Icons.person,
    );
    try {
      final details = await _routeService.getRouteDetails(origin, destination);
      if (details == null) {
        emit(state.copyWith(
            isLoading: false,
            markers: {
              Marker(
                markerId: const MarkerId('origin'),
                position: origin,
                icon: updatedIcon,
              ),
              Marker(
                markerId: const MarkerId('destination'),
                position: destination,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ),
              ),
            },
            error: "Route not found"));
        return;
      }

      final points = details['polylinePoints'] as List<LatLng>;
      _routePolylinePoints = points;

      final routeInfo = "${details['distance']} • ${details['duration']}";

      emit(
        state.copyWith(
          hasLocationPermission: true,
          markers: {
            Marker(
              markerId: const MarkerId('origin'),
              position: origin,
              icon: updatedIcon,
            ),
            Marker(
              markerId: const MarkerId('destination'),
              position: destination,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
            ),
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: _routePolylinePoints,
              color: Colors.blue,
              width: 5,
            ),
          },
          routeInfo: routeInfo,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
        markers: {
          Marker(
            markerId: const MarkerId('origin'),
            position: origin,
            icon: updatedIcon,
          ),
          Marker(
            markerId: const MarkerId('destination'),
            position: destination,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
          ),
        },
      ));
    }
  }

  void _updatePolylineProgress(LatLng currentLocation) async {
    if (_routePolylinePoints.isEmpty) return;

    // Get nearest snapped point on polyline
    final (
      snappedPoint,
      distance,
      nearestIndex,
    ) = LocatorService.getNearestPointOnPolyline(
      currentLocation,
      _routePolylinePoints,
    );
    if (distance > kDetourThreshold) {
      _drawRoute(currentLocation, state.destination!);
      return;
    }

    // 🔹 Build traveled & remaining paths
    final traveled = _routePolylinePoints.sublist(0, nearestIndex)
      ..add(snappedPoint);
    final remaining = [
      snappedPoint,
      ..._routePolylinePoints.sublist(nearestIndex + 1),
    ];

    // 🔹 Update marker (stick to route instead of GPS raw)
    final updatedIcon = await _createCircleAvatarMarker(
      color: Colors.yellow,
      icon: Icons.person,
    );

    final newOriginMarker = Marker(
      markerId: const MarkerId('origin'),
      position: currentLocation, // ✅ snap marker to polyline
      icon: updatedIcon,
    );

    final updatedMarkers = {
      ...state.markers
        ..removeWhere((m) => m.markerId == const MarkerId('origin')),
      newOriginMarker,
    };

    // 🔹 Emit with two polylines
    emit(
      state.copyWith(
        polylines: {
          Polyline(
            polylineId: const PolylineId('traveled'),
            points: traveled,
            color: Colors.blue.withValues(alpha: 0.4), // lighter (past path)
            width: 5,
          ),
          Polyline(
            polylineId: const PolylineId('remaining'),
            points: remaining,
            color: Colors.blue, // solid (remaining path)
            width: 5,
          ),
        },
        markers: updatedMarkers,
      ),
    );
  }

  Future<void> updateDestination(LatLng newDest) async {
    if (state.currentPosition == null) return;
    _updatePolylineProgress(
      LatLng(state.currentPosition!.latitude, state.currentPosition!.longitude),
    );
  }

  Future<void> receiveOrder(int orderId) async {
    emit(state.copyWith(buttonClick: true));
    final response = await _branchMapRepository.receiveOrder(orderId);
    emit(state.copyWith(buttonClick: false));

    if (response != null) {
      emit(state.copyWith(buttonClick: false, recieveOrder: true));
    } else {
      emit(state.copyWith(buttonClick: false));
    }
  }

  @override
  Future<void> close() {
    _positionStream?.cancel();
    return super.close();
  }
}

Future<BitmapDescriptor> _createCircleAvatarMarker({
  Color color = Colors.yellow,
  double size = 100,
  IconData? icon,
  Color iconColor = Colors.white,
}) async {
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder);
  final Paint paint = Paint()..color = color;
  canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint);
  if (icon != null) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: size / 2,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: iconColor,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size - textPainter.width) / 2, (size - textPainter.height) / 2),
    );
  }
  final picture = recorder.endRecording();
  final ui.Image image = await picture.toImage(size.toInt(), size.toInt());
  final ByteData? bytes = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );
  final Uint8List pngBytes = bytes!.buffer.asUint8List();
  return BitmapDescriptor.fromBytes(pngBytes);
}

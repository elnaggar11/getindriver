import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';

class MapState extends Equatable {
  final bool hasLocationPermission;
  final bool isLoading;
  final Position? currentPosition;
  final LatLng? destination;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final String? routeInfo;
  final String? error;
  final bool buttonClick;
  final bool recieveOrder;

  const MapState({
    this.hasLocationPermission = false,
    this.isLoading = false,
    this.currentPosition,
    this.destination,
    this.markers = const {},
    this.polylines = const {},
    this.routeInfo,
    this.error,
    this.buttonClick = false,
    this.recieveOrder = false,
  });

  MapState copyWith({
    bool? hasLocationPermission,
    bool? isLoading,
    Position? currentPosition,
    LatLng? destination,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    String? routeInfo,
    String? error,
    bool? buttonClick,
    bool? recieveOrder,
  }) {
    return MapState(
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      isLoading: isLoading ?? this.isLoading,
      currentPosition: currentPosition ?? this.currentPosition,
      destination: destination ?? this.destination,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      routeInfo: routeInfo ?? this.routeInfo,
      error: error,
      buttonClick: buttonClick ?? this.buttonClick,
      recieveOrder: recieveOrder ?? this.recieveOrder,
    );
  }

  @override
  List<Object?> get props => [
    hasLocationPermission,
    isLoading,
    currentPosition,
    destination,
    markers,
    polylines,
    routeInfo,
    error,
    buttonClick,
    recieveOrder,
  ];
  LatLng get initialTarget {
    if (currentPosition != null) {
      return LatLng(
        currentPosition!.latitude,
        currentPosition!.longitude,
      );
    }
    return destination ?? const LatLng(0, 0);
  }
}

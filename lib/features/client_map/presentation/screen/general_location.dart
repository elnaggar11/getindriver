import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/services/location/map_route_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:getin_driver/core/utils/Locator.dart';
import 'package:getin_driver/core/services/location/location_service.dart';
import 'package:getin_driver/features/client_map/cubit/Client_order_map_state.dart';
import 'package:getin_driver/features/client_map/cubit/client_order_map_controller.dart';
import 'package:getin_driver/features/client_map/domain/repository/repository.dart';
import 'package:getin_driver/features/order_details/presentation/widgets/stack_app_bar.dart';

class SimpleMapViewPage extends StatelessWidget {
  final LatLng destinationPoint;

  const SimpleMapViewPage({
    super.key,
    required this.destinationPoint,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientOrderMapController(
        LocatorService(),
        RouteService(),
        locator<ClientOrderMapRepository>(),
      )..init(destinationPoint),
      child: BlocBuilder<ClientOrderMapController, ClientOrderMapState>(
        builder: (context, state) {
          final cubit = context.read<ClientOrderMapController>();

          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: state.initialTarget,
                    zoom: 13.5,
                  ),
                  markers: _buildMarkers(state),
                  myLocationEnabled: state.hasLocationPermission,
                  myLocationButtonEnabled: true,
                  onMapCreated: (controller) {
                    cubit.mapController = controller;
                    _fitBoundsToMarkers(controller, state);
                  },
                ),
                StackAppBar(
                  title: LocalizationHelper.tr.destination_overview,
                  onBack: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Create markers for user & destination
  Set<Marker> _buildMarkers(ClientOrderMapState state) {
    final markers = <Marker>{};

    if (state.currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(state.currentPosition!.latitude,
              state.currentPosition!.longitude),
          infoWindow:  InfoWindow(title: LocalizationHelper.tr.your_location),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: state.destination!,
        infoWindow:  InfoWindow(title: LocalizationHelper.tr.destination),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    return markers;
  }

  /// Adjust camera to fit both locations
  void _fitBoundsToMarkers(
      GoogleMapController controller, ClientOrderMapState state) {
    if (state.currentPosition == null || state.destination == null) return;

    final southwest = LatLng(
      state.currentPosition!.latitude < state.destination!.latitude
          ? state.currentPosition!.latitude
          : state.destination!.latitude,
      state.currentPosition!.longitude < state.destination!.longitude
          ? state.currentPosition!.longitude
          : state.destination!.longitude,
    );

    final northeast = LatLng(
      state.currentPosition!.latitude > state.destination!.latitude
          ? state.currentPosition!.latitude
          : state.destination!.latitude,
      state.currentPosition!.longitude > state.destination!.longitude
          ? state.currentPosition!.longitude
          : state.destination!.longitude,
    );

    final bounds = LatLngBounds(southwest: southwest, northeast: northeast);

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
  }
}

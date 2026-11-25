import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/utils/Locator.dart';
import 'package:getin_driver/features/client_map/cubit/Client_order_map_state.dart';
import 'package:getin_driver/features/client_map/cubit/client_order_map_controller.dart';
import 'package:getin_driver/features/client_map/domain/repository/repository.dart';
import 'package:getin_driver/features/client_map/presentation/widget/client_order_info_card.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/services/location/location_service.dart';
import '../../../../core/services/location/map_route_service.dart';
import '../../../order_details/presentation/widgets/stack_app_bar.dart';

class ClientMapPage extends StatelessWidget {
  final LatLng destinationPoint;
  final OrderModel order;

  const ClientMapPage({
    super.key,
    required this.destinationPoint,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientOrderMapController(
        LocatorService(),
        RouteService(),
        locator<ClientOrderMapRepository>(),
      )..init(destinationPoint),
      child: BlocConsumer<ClientOrderMapController, ClientOrderMapState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<ClientOrderMapController>();

          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: state.initialTarget,
                    zoom: 14,
                  ),
                  onTap: (p0) {
                    print(p0);
                  },
                  markers: state.markers,
                  polylines: state.polylines,
                  myLocationEnabled: state.hasLocationPermission,
                  myLocationButtonEnabled: state.hasLocationPermission,
                ),
                if (state.error != null)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        state.error!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                if (state.routeInfo != null)
                  Positioned(
                    bottom: 80,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        state.routeInfo!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                StackAppBar(
                  title: LocalizationHelper.tr.customer_delivery,
                  onBack: () => Navigator.pop(context),
                ),
                /* Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClientOrderInfoCard(order: order),
                ), */
              ],
            ),
            bottomNavigationBar: ClientOrderInfoCard(order: order),
            floatingActionButton: FloatingActionButton(
              onPressed: () => cubit.updateDestination(destinationPoint),
              child: const Icon(Icons.refresh),
            ),
          );
        },
      ),
    );
  }
}

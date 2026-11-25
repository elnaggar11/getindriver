import 'package:getin_driver/core/localization/localization_helper.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/Router/Router.dart';
import 'package:getin_driver/core/Router/navigation_helper.dart';
import 'package:getin_driver/core/services/alerts.dart';
import 'package:getin_driver/features/qr_reader/controller/qr_reader_cubit.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:scanning_effect/scanning_effect.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key, this.orderId});
  final int? orderId;

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  bool _isScanning = false;
  String? _scannedData;

  void _toggleScanner() {
    setState(() {
      _isScanning = !_isScanning;
      if (_isScanning) {
        _controller.start();
      } else {
        _controller.stop();
      }
    });
  }

  void _onDetect(BarcodeCapture capture, BuildContext context) {
    final barcode = capture.barcodes.first;
    final value = barcode.rawValue;

    if (value != null && value.isNotEmpty) {
      setState(() {
        // _scannedData = value;
        _isScanning = false;
        log(value, name: LocalizationHelper.tr.qr_data);
        QrReaderCubit.get(context).confirmClientRecieveOrder(value);
      });

      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrReaderCubit(widget.orderId),
      child: BlocConsumer<QrReaderCubit, QrReaderState>(
        listener: (context, state) {
          if (state is QrReaderSuccess) {
            NavigationService.popUntil(Routes.layoutScreen);
            Alerts.snack(
              text: LocalizationHelper.tr.is_order_confirmed,
              state: SnackState.success,
            );
          }
        },

        //39.940140, -118.755726
        builder: (context, state) {
          return Scaffold(
            backgroundColor: LightThemeColors.primary,
            body: Column(
              children: [
                const SizedBox(height: 50),
                // App Bar
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      LocalizationHelper.tr.scan_qr_code,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Scanner Container
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (_isScanning)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: ScanningEffect(
                                      borderLineStrokeWidth: 2,
                                      scanningHeightOffset: 0.01,
                                      scanningColor: const Color(0xff0C3B33),
                                      borderLineColor: LightThemeColors.primary,
                                      child: MobileScanner(
                                        controller: _controller,
                                        /* overlayBuilder: (context, constraints) {
                                          return _ScannerOverlay(
                                            animation: _animation,
                                          );
                                        }, */
                                        onDetect: (capture) =>
                                            _onDetect(capture, context),
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: LightThemeColors.primary
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      _scannedData == null
                                          ? LocalizationHelper
                                                .tr
                                                .scan_instruction_message
                                          : LocalizationHelper.tr
                                                .last_scanned_data(
                                                  _scannedData!,
                                                ),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Round scan button
                        Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0F4037),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              _isScanning ? Icons.stop : Icons.qr_code_scanner,
                            ),
                            color: Colors.white,
                            onPressed: _toggleScanner,
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ScannerOverlay extends StatelessWidget {
  final Animation<double> animation;

  const _ScannerOverlay({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final position = animation.value * MediaQuery.of(context).size.height;
        return Transform.translate(
          offset: Offset(0, position),
          child: Container(height: 2, color: Colors.redAccent.withOpacity(0.8)),
        );
      },
    );
  }
}

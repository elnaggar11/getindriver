import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback? onRefresh;

  const ErrorScreen({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.redAccent),
          const SizedBox(height: 16),
           Text(
            LocalizationHelper.tr.something_went_wrong,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
           Text(
            LocalizationHelper.tr.please_try_again,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label:  Text(LocalizationHelper.tr.refresh),
          ),
        ],
      ),
    );
  }
}

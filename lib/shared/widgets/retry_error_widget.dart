import 'package:flutter/material.dart';
import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/shared/widgets/button_widget.dart';

/// Displays an error message with a retry button for recoverable failures.
class RetryErrorWidget extends StatelessWidget {
  const RetryErrorWidget({super.key, this.message, required this.onRetry});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final String displayMessage =
        (message != null && message!.trim().isNotEmpty)
        ? message!
        : LocalizationHelper.tr.something_went_wrong;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: LightThemeColors.error,
              size: 48,
            ),
            16.ph,
            Text(
              displayMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: LightThemeColors.greyDark,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            24.ph,
            ButtonWidget(
              width: 180,
              height: 48,
              title: LocalizationHelper.tr.retry_action,
              onTap: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}

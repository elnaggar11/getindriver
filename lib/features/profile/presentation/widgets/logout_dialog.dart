import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/core/Router/Router.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/utils.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close, color: Colors.grey, size: 24),
            ),
          ),
          const SizedBox(height: 16),

          // Logout icon
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: LightThemeColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.logout, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            LocalizationHelper.tr.confirm_logout_message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            LocalizationHelper.tr.action_reversible_message,
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Add your logout logic here
                    _handleLogout(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightThemeColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    LocalizationHelper.tr.log_out,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    LocalizationHelper.tr.cancel,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    Utils.clearUser();
    


    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(Routes.loginSignupToggleScreen, (route) => false);
  }
}

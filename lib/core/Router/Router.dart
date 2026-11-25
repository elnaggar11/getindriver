import 'package:getin_driver/features/client_map/presentation/screen/client_map.dart';
import 'package:getin_driver/features/client_map/presentation/screen/general_location.dart';
import 'package:getin_driver/features/static_pages/presentaion/screens/terms_screen.dart';
import 'package:getin_driver/features/support/presentation/screens/support_screen.dart';

import '../../features/notification/presentation/screens/notification_screen.dart';
import 'package:getin_driver/features/auth/presentation/screens/sign_up/main_sign_up.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';
import 'package:getin_driver/features/order_map/presentation/screen/map.dart';
import 'package:getin_driver/features/profile/presentation/screens/change_language.dart';
import 'package:getin_driver/features/profile/presentation/screens/privacy_policy.dart';
import 'package:getin_driver/features/profile/presentation/screens/terms_condition.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/edit_profile/presentation/screens/edit_profile_screen.dart';
import '../../features/order_details/presentation/screens/order_details_screen.dart';
import '../../features/order_details/presentation/screens/qr_reader.dart';
import 'package:getin_driver/features/layout/presentation/screens/layout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/forget_password/forget_password_screen.dart';
import '../../features/auth/presentation/screens/login/login_screen.dart';
import '../../features/auth/presentation/screens/login_signUp_toggle/login_signup_toggle_screen.dart';
import '../../features/auth/presentation/screens/otp/otp_screen.dart';
import '../../features/auth/presentation/screens/reset_password/reset_password_screen.dart';
import '../../features/splash/presentation/screens/on_boarding/on_boarding_screen.dart';
import '../../features/splash/presentation/screens/splash/splash.dart';

class Routes {
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/onboardingScreen";
  static const String loginScreen = "loginScreen";
  static const String registerScreen = "registerScreen";
  static const String forgetPassScreen = "/forgetPassScreen";
  static const String otpScreen = "/OtpScreen";
  static const String layoutScreen = "/LayoutScreen";
  static const String loginSignupToggleScreen = "/LoginSignupToggleScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String homeScreen = "homeScreen";
  static const String orderDetailsScreen = "orderDetailsScreen";
  static const String editProfileScreen = "editProfileScreen";
  static const String changeLanguageScreen = "changeLanguageScreen";
  static const String termsConditionScreen = "termsConditionScreen";
  static const String privacyPolicyScreen = "privacyPolicyScreen";
  static const String qrScanScreen = "qrScanScreen";
  static const String mapScreen = "mapScreen";
  static const String generalMap = "generalMap";
  static const String clientMapScreen = "clientMapScreen";
  static const String notificationScreen = "notificationScreen";
  static const String support = "supportScreen";
}

class RouteGenerator {
  static String currentRoute = "";

  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    currentRoute = routeSettings.name.toString();
    switch (routeSettings.name) {
      case Routes.support:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const SupportScreen();
          },
        );
      case Routes.qrScanScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return QrScanPage(orderId: routeSettings.arguments as int?);
          },
        );
      case Routes.clientMapScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            final arguments = routeSettings.arguments as Map<String, dynamic>;
            return ClientMapPage(
              destinationPoint: (arguments['location'] as LatLng),
              order: (arguments['order'] as OrderModel),
            );
          },
        );
      case Routes.generalMap:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            final arguments = routeSettings.arguments as Map<String, dynamic>;
            return SimpleMapViewPage(
              destinationPoint: (arguments['location'] as LatLng),
              //order: (arguments['order'] as OrderModel),
            );
          },
        );
      case Routes.mapScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            final arguments = routeSettings.arguments as Map<String, dynamic>;
            return MapPage(
              destinationPoint: (arguments['location'] as LatLng),
              order: (arguments['order'] as OrderModel),
            );
          },
        );
      case Routes.layoutScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const LayoutScreen();
          },
        );
      case Routes.onboardingScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const OnboardingScreen();
          },
        );
      case Routes.loginScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const LoginScreen();
          },
        );
      case Routes.resetPasswordScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return ResetPasswordScreen(
              code: (routeSettings.arguments as NewPasswordArgs).code,
              email: (routeSettings.arguments as NewPasswordArgs).email,
            );
          },
        );
      case Routes.otpScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return OtpScreen(
              onReSend: (routeSettings.arguments as OtpArguments).onReSend,
              onSubmit: (routeSettings.arguments as OtpArguments).onSubmit,
              sendTo: (routeSettings.arguments as OtpArguments).sendTo,
              init: (routeSettings.arguments as OtpArguments).init,
            );
          },
        );
      case Routes.forgetPassScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const ForgetPasswordScreen();
          },
        );
      case Routes.loginSignupToggleScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const LoginSignupToggleScreen();
          },
        );
      case Routes.changeLanguageScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const ChangeLanguageScreen();
          },
        );
      case Routes.registerScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const MainSignUpScreen();
          },
        );
      case Routes.termsConditionScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const TermsScreen();
          },
        );
      case Routes.privacyPolicyScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const PrivacyPolicyScreen();
          },
        );
      // case Routes.SplashScreen:
      //   return CupertinoPageRoute(
      //       settings: routeSettings,
      //       builder: (_) {
      //         return const SplashScreen();
      //       });
      case Routes.splashScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const SplashScreen();
          },
        );

      case Routes.orderDetailsScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return OrderDetailsScreen(
              orderModel: (routeSettings.arguments as OrderModel),
            );
          },
        );
      case Routes.editProfileScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const EditProfileScreen();
          },
        );
      case Routes.notificationScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const NotificationScreen();
          },
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> getNestedRoute(RouteSettings routeSettings) {
    currentRoute = routeSettings.name.toString();
    switch (routeSettings.name) {
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return CupertinoPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("مسار غير موجود")),
        body: const Center(child: Text("مسار غير موجود")),
      ),
    );
  }
}

class OtpArguments {
  final String sendTo;
  final bool? init;
  final dynamic Function(String) onSubmit;
  final void Function() onReSend;

  OtpArguments({
    required this.sendTo,
    required this.onSubmit,
    required this.onReSend,
    this.init,
  });
}

class NewPasswordArgs {
  final String code;
  final String email;
  const NewPasswordArgs({required this.code, required this.email});
}

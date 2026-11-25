import 'package:flutter/material.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/theme/light_theme.dart';

enum OrderStatus { newOrder, onDelivery, delivered, cancelled, shipping }

extension OrderStatusExtension on OrderStatus {
  String get name {
    switch (this) {
      case OrderStatus.newOrder:
        return LocalizationHelper.tr.newOrder;
      case OrderStatus.onDelivery || OrderStatus.shipping:
        return LocalizationHelper.tr.onDelivery;

      case OrderStatus.delivered:
        return LocalizationHelper.tr.delivered;
      case OrderStatus.cancelled:
        return LocalizationHelper.tr.cancelled;
    }
  }

  String get svgPath {
    switch (this) {
      case OrderStatus.delivered:
        return SvgMang.addFinance;

      case OrderStatus.cancelled:
        return SvgMang.trash;
      default:
        return "";
    }
  }

  String get nameStatus {
    switch (this) {
      case OrderStatus.newOrder:
        return LocalizationHelper.tr.newOrder;
      case OrderStatus.onDelivery || OrderStatus.shipping:
        return LocalizationHelper.tr.in_progress;
      case OrderStatus.delivered:
        return LocalizationHelper.tr.completed;
      case OrderStatus.cancelled:
        return LocalizationHelper.tr.cancelled;
    }
  }

  String get backendName {
    switch (this) {
      case OrderStatus.newOrder:
        return 'new';
      case OrderStatus.onDelivery || OrderStatus.shipping:
        return 'on-delivery';
      case OrderStatus.delivered:
        return 'delivered';
      case OrderStatus.cancelled:
        return 'cancelled';
    }
  }

  Color get financeColor {
    switch (this) {
      case OrderStatus.newOrder:
        return const Color(0x19700034);
      case OrderStatus.onDelivery || OrderStatus.shipping:
        return const Color(0xFFFFBE33);
      case OrderStatus.delivered:
        return LightThemeColors.primary;
      case OrderStatus.cancelled:
        return const Color(0xFFFF4658);
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.newOrder:
        return const Color(0x19700034);
      case OrderStatus.onDelivery || OrderStatus.shipping:
        return const Color(0xFFFFBE33);
      case OrderStatus.delivered:
        return const Color(0xFF18EC82);
      case OrderStatus.cancelled:
        return const Color(0xFFFF4658);
    }
  }

  Color get colorText {
    switch (this) {
      case OrderStatus.newOrder:
        return const Color(0xFF197000);
      case OrderStatus.onDelivery || OrderStatus.shipping:
        return Colors.black;
      case OrderStatus.delivered:
        return Colors.black;
      case OrderStatus.cancelled:
        return Colors.white;
    }
  }
}

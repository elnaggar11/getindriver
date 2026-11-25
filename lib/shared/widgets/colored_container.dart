import 'package:flutter/material.dart';

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.color = const Color(0xFFF8F8F8),
    this.radius = 35,
    this.child,
  });
  final double? width, height;
  final double radius;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: child,
    );
  }
}

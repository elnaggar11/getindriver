import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/resources/font_manager.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/extensions/all_extensions.dart';
import '../../shared/widgets/text_widget.dart';

class ButtonWidget extends StatefulWidget {
  final String? title;
  final String? fontFamily;
  final double width, height, radius;
  final Widget? child;
  final Gradient? gradient;
  final double? fontSize;
  final FontWeight? fontweight;
  final Alignment? alignment;
  final Color? textColor, buttonColor, borderColor;
  final void Function()? onTap;
  final bool withBorder;
  final bool witharrows;

  const ButtonWidget({
    super.key,
    this.gradient,
    this.witharrows = false,
    this.title,
    this.width = double.infinity,
    this.height = 68.0,
    this.onTap,
    this.fontFamily,
    this.child,
    this.fontSize,
    this.fontweight,
    this.alignment,
    this.textColor = LightThemeColors.white,
    this.buttonColor,
    this.borderColor,
    this.withBorder = false,
    this.radius = 40.0,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      3,
      (i) => AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.5,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        _controllers[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: widget.gradient,
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            widget.buttonColor ?? LightThemeColors.primary,
          ),
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
          shadowColor: WidgetStateProperty.all<Color>(Colors.white),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              side: widget.withBorder
                  ? BorderSide(
                      color: widget.borderColor ?? context.secondaryColor,
                    )
                  : const BorderSide(color: Colors.transparent),
            ),
          ),
        ),
        child: widget.witharrows == true
            ? widget.child ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 10.pw,
                      SvgPicture.asset(SvgMang.getStartIcon),
                      Text(
                        widget.title ?? LocalizationHelper.tr.is_ok,
                        style: TextStyles.font16BlackSemiBold.copyWith(
                          color: widget.textColor ?? LightThemeColors.white,
                          fontSize: widget.fontSize ?? 16,
                          fontWeight: widget.fontweight ?? FontWeights.medium,
                        ),
                      ),

                      Row(
                        children: [
                          ...List.generate(3, (i) {
                            return FadeTransition(
                              opacity: _animations[i],
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              ),
                            );
                          }),
                          10.pw,
                        ],
                      ),
                    ],
                  )
            : widget.child ??
                  widget.title.text(
                    fontWeight: widget.fontweight ?? FontWeight.w400,
                    fontSize: widget.fontSize ?? 16,
                    fontFamily: widget.fontFamily,
                    color: widget.textColor ?? Colors.white,
                  ),
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    required this.function,
    required this.text,
    this.fontweight,
    this.color,
    this.size,
    this.fontFamily,
  });
  final Function function;
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? fontweight;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        function();
      },
      child: TextWidget(
        text,
        fontWeight: fontweight ?? FontWeight.w500,
        fontFamily: fontFamily ?? FontConstants.fontFamily,
        fontSize: size ?? 16,
        color: color ?? context.secondaryColor,
        //  style: TextStyle(color: AppColors.secondary),
      ),
      // style: TextButton.styleFrom(
      //   elevation: 0,
      //   textStyle: TextStyle(
      //     fontWeight: FontWeight.w600,
      //     fontSize: (width <= 550) ? 13 : 17,
      //   ),
      // ),
    );
  }
}

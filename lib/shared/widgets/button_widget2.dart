import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/shared/widgets/flip_ar.dart';

class GetStartedSliderButton extends StatefulWidget {
  final VoidCallback onTap;
  final String? text;

  const GetStartedSliderButton({super.key, required this.onTap, this.text});

  @override
  State<GetStartedSliderButton> createState() => _GetStartedSliderButtonState();
}

class _GetStartedSliderButtonState extends State<GetStartedSliderButton>
    with TickerProviderStateMixin {
  double dragOffset = 0.0;
  bool completed = false;
  late double maxDrag;

  late final List<AnimationController> _arrowControllers;
  late final List<Animation<double>> _arrowAnimations;

  @override
  void initState() {
    super.initState();

    _arrowControllers = List.generate(3, (i) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      );
      controller.repeat(reverse: true);
      return controller;
    });

    _arrowAnimations = _arrowControllers.map((controller) {
      return Tween<double>(
        begin: 0.3,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();
  }

  @override
  void dispose() {
    for (final controller in _arrowControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (completed) return;

    setState(() {
      dragOffset += details.delta.dx;
      dragOffset = dragOffset.clamp(0.0, maxDrag);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (dragOffset >= maxDrag * 0.85) {
      setState(() => completed = true);
      widget.onTap();
      setState(() => dragOffset = 0.0);
      setState(() => completed = false);
    } else {
      // Animate back
      setState(() => dragOffset = 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = constraints.maxWidth;
        maxDrag = fullWidth - 68; // 68 is height

        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: 68,
            width: fullWidth,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0E4037),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Centered Text
                IgnorePointer(
                  ignoring: true,
                  child: Text(
                    widget.text ?? LocalizationHelper.tr.start_action,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Animated Arrows
                Positioned(
                  right: 16,
                  child: Row(
                    children: List.generate(3, (index) {
                      return FadeTransition(
                        opacity: _arrowAnimations[index],
                        child: const Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: FlipAr(
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // Draggable Handle
                Positioned(
                  left: dragOffset,
                  child: GestureDetector(
                    onHorizontalDragUpdate: _onDragUpdate,
                    onHorizontalDragEnd: _onDragEnd,
                    child: Container(
                      width: 65,
                      height: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: FlipAr(
                        child: const Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

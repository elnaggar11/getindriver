import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';

class StepperController extends ChangeNotifier {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  void jumpToStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void nextStep({int? maxStep}) {
    if (maxStep == null || _currentStep < maxStep - 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }
}

class StepperWithController extends StatefulWidget {
  final int totalSteps;
  final IndexedWidgetBuilder stepBuilder;
  final StepperController controller;

  const StepperWithController({
    super.key,
    required this.totalSteps,
    required this.stepBuilder,
    required this.controller,
  });

  @override
  State<StepperWithController> createState() => _StepperWithControllerState();
}

class _StepperWithControllerState extends State<StepperWithController> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onStepChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onStepChange);
    super.dispose();
  }

  void _onStepChange() {
    setState(() {}); // Rebuild UI when current step changes
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.controller.currentStep;

    return Column(
      children: [
        /// Step header (same as before)
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;

              Color bgColor;
              Color textColor;
              Widget content;

              if (isCompleted) {
                bgColor = const Color(0xFF0E4037);
                textColor = Colors.white;
                content = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocalizationHelper.tr.current_step_label(
                        (index + 1).toString(),
                      ),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.check, color: Colors.white, size: 16),
                  ],
                );
              } else if (isCurrent) {
                bgColor = Colors.white;
                textColor = Colors.black;
                content = Text(
                  LocalizationHelper.tr.current_step_label(
                    (index + 1).toString(),
                  ),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                );
              } else {
                bgColor = Colors.transparent;
                textColor = Colors.black54;
                content = Text(
                  LocalizationHelper.tr.current_step_label(
                    (index + 1).toString(),
                  ),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                );
              }

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: content,
              );
            }),
          ),
        ),

        /// Step body
        Expanded(child: widget.stepBuilder(context, currentStep)),
      ],
    );
  }
}

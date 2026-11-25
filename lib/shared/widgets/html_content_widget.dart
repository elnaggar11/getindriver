import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:getin_driver/core/theme/light_theme.dart';

/// Renders CMS HTML content (`h2`, `p`, `ul`, `li`, `em`) with consistent
/// typography and automatic text direction detection.
class HtmlContentWidget extends StatelessWidget {
  const HtmlContentWidget({super.key, required this.html, this.textStyle});

  final String html;
  final TextStyle? textStyle;

  static final RegExp _arabicRegex = RegExp(r'[\u0600-\u06FF]');

  @override
  Widget build(BuildContext context) {
    final TextDirection direction = _arabicRegex.hasMatch(html)
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: direction,
      child: HtmlWidget(
        html,
        textStyle:
            textStyle ??
            const TextStyle(
              color: LightThemeColors.greyDark,
              fontSize: 15,
              height: 1.6,
            ),
        customStylesBuilder: (element) {
          switch (element.localName) {
            case 'h2':
              return {'font-size': '18px', 'font-weight': '700'};
            case 'p':
              return {'margin-bottom': '10px'};
            case 'ul':
              return {'padding-left': '18px', 'margin-bottom': '10px'};
            case 'li':
              return {'margin-bottom': '6px'};
            default:
              return null;
          }
        },
      ),
    );
  }
}

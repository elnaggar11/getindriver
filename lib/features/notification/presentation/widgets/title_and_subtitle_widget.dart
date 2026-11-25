import 'package:flutter/material.dart';

class TitleAndSubtitleWidget extends StatelessWidget {
  const TitleAndSubtitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF121212),
            fontSize: 16,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF818181),
            fontSize: 14,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }
}

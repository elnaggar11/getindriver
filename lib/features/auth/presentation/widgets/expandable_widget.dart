import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({
    super.key,
    required this.title,
    required this.content,
  });
  final Widget title;
  final Widget content;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: IgnorePointer(child: widget.title),
        ),
        if (isExpanded) widget.content,
      ],
    );
  }
}

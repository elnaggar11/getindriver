import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';

class CustomFilePicker extends StatefulWidget {
  final Function(FilePickerResult?) onFilePicked;
  final String? hintText;
  final List<String>? allowedExtensions;
  final String? svgIcon;
  final FileType type;

  const CustomFilePicker({
    super.key,
    required this.onFilePicked,
    this.hintText,
    this.svgIcon,
    this.allowedExtensions = const ['pdf', 'png', 'jpg', 'jpeg'],
    this.type = FileType.custom,
  });

  @override
  State<CustomFilePicker> createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  String? fileName;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: (widget.type == FileType.custom)
          ? widget.allowedExtensions
          : null,
      type: widget.type,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
      widget.onFilePicked(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickFile,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: LightThemeColors.offWhite,
          borderRadius: BorderRadius.circular(40),
          //  border: Border.all(color: Colors.grey.shade200, width: 2),
        ),
        child: Row(
          children: [
            SvgPicture.asset(widget.svgIcon ?? SvgMang.file),
            /* Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child:,
            ), */
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName ??
                        widget.hintText ??
                        LocalizationHelper.tr.driving_license_photo,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: fileName == null
                          ? FontWeight.w600
                          : FontWeight.w800,
                    ),
                  ),
                  Text(
                    widget.allowedExtensions?.join(" - ") ?? LocalizationHelper.tr.unspecified_phrase,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(SvgMang.upload),
          ],
        ),
      ),
    );
  }
}

import 'package:getin_driver/core/localization/localization_helper.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getin_driver/core/services/alerts.dart';
import 'package:getin_driver/core/services/media/alert_of_media.dart';

class ImagePickerWidget extends StatefulWidget {
  final bool allowMultiple; // Toggle between single and multiple image picking
  final bool showalltime;
  final int maxImages; // Maximum number of images allowed
  final Function(File? image)? onImageSelected;
  final Function()? onImagesDeleted;
  final Function(String)? oninitimagedeleated;
  final bool showImage;
  final bool canReplace;
  final String? initialImages;
  final Widget Function(
    File? image,
    String initialImages,
    Future<void> Function() pickImage,
  )
  builder;

  const ImagePickerWidget({
    required this.builder,
    this.oninitimagedeleated,
    this.initialImages,
    this.allowMultiple = false,
    this.showalltime = true,
    this.maxImages = 1,
    this.onImageSelected,
    this.onImagesDeleted,
    this.showImage = true,
    this.canReplace = false,
    super.key,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? pickedImage;
  String initialImages = LocalizationHelper.tr.unspecified_phrase;
  @override
  void initState() {
    super.initState();
    initialImages =
        widget.initialImages ?? LocalizationHelper.tr.unspecified_phrase;
  }

  void onImageSelected(File? image) {
    if (image != null) {
      setState(() {
        pickedImage = image;
        widget.onImageSelected?.call(image);
      });
    }
  }

  Future<void> _pickImages() async {
    Alerts.bottomSheet(
      context,
      child: AlertOfMedia(
        onGallerySelected: onImageSelected,
        onCameraSelected: onImageSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            _pickImages();
          },
          child: widget.builder(pickedImage, initialImages, _pickImages),
        ),
      ],
    );
  }
}

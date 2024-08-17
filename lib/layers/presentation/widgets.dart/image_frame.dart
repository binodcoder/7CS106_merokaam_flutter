import 'dart:io';
import 'package:flutter/material.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colour_manager.dart';

class ImageFrame extends StatelessWidget {
  final String? imagePath;
  final Size size;

  const ImageFrame({
    Key? key,
    this.imagePath,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.3,
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.white),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: size.width,
          height: size.height * 0.3,
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath == null) {
      return Image.asset(
        ImageAssets.appIcon,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath!),
        fit: BoxFit.cover,
      );
    }
  }
}

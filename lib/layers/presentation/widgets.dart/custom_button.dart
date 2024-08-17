import 'package:flutter/material.dart';

import '../../../resources/values_manager.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Size size;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s50,
      child: OutlinedButton(
        onPressed: onTap,
        child: Text(
          text,
        ),
      ),
    );
  }
}

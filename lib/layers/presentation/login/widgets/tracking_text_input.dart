import 'dart:async';

import 'package:flutter/material.dart';


import '../../../../resources/colour_manager.dart';
import '../../../../resources/global_declaration.dart';
import '../../../../resources/values_manager.dart';
import 'input_helper.dart';

class TrackingTextInput extends StatefulWidget {
  const TrackingTextInput({
    Key? key,
    this.onCaretMoved,
    this.onTextChanged,
    this.hint,
    required this.isObscured,
    required this.icon,
    required this.textEditingController,
  }) : super(key: key);

  final CaretMoved? onCaretMoved;
  final TextChanged? onTextChanged;
  final String? hint;

  final bool isObscured;
  final IconButton icon;
  final TextEditingController textEditingController;

  @override
  State<TrackingTextInput> createState() => _TrackingTextInputState();
}

class _TrackingTextInputState extends State<TrackingTextInput> {
  final GlobalKey _fieldKey = GlobalKey();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(() {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          final RenderObject? fieldBox = _fieldKey.currentContext?.findRenderObject();
          var caretPosition = fieldBox is RenderBox ? getCaretPosition(fieldBox) : null;

          widget.onCaretMoved?.call(caretPosition);
        }
      });
      widget.onTextChanged?.call(widget.textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppHeight.h20),
      child: TextFormField(
        key: _fieldKey,
        controller: widget.textEditingController,
        obscureText: widget.isObscured,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '*Required';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.hint,
          suffixIcon: widget.icon,
          fillColor: ColorManager.redWhite,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppRadius.r10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.blueGrey),
            borderRadius: BorderRadius.circular(AppRadius.r10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary),
            borderRadius: BorderRadius.circular(AppRadius.r10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.red),
            borderRadius: BorderRadius.circular(AppRadius.r10),
          ),
        ),
      ),
    );
  }
}

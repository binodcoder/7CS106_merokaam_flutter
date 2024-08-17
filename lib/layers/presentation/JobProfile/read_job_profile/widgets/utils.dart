import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../resources/colour_manager.dart';
import '../../../../../resources/font_manager.dart';
import '../../../../../resources/values_manager.dart';

class Utils {
  static Widget getErrorMessageWidget(String errorMessage) {
    return Center(
      child: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: ColorManager.error,
        ),
      ),
    );
  }

  static toastMessage(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: ColorManager.darkGrey,
      textColor: ColorManager.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: AppWidth.w20, vertical: AppHeight.h10),
        padding: EdgeInsets.all(AppHeight.h14),
        duration: const Duration(seconds: 2),
        borderRadius: BorderRadius.circular(AppRadius.r10),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: ColorManager.error,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: FontSize.s20,
          color: ColorManager.white,
        ),
      )..show(context),
    );
  }

  static void flushBarMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: AppWidth.w20, vertical: AppHeight.h10),
        padding: EdgeInsets.all(AppHeight.h14),
        duration: const Duration(seconds: 2),
        borderRadius: BorderRadius.circular(AppRadius.r10),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: ColorManager.primary,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: FontSize.s20,
          color: ColorManager.white,
        ),
      )..show(context),
    );
  }

  static getErrorMessage(String errorMessage) {
    return Center(
        child: Text(
      errorMessage,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: ColorManager.error,
      ),
    ));
  }
}

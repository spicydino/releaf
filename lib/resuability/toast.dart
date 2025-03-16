import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final IconData? icon;
  final bool isIcon;
  final bool isLoading;
  final double height;
  final double width;
  final ToastGravity gravity;
  final Duration duration;

  const CustomToast({
    super.key,
    required this.message,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.icon,
    this.isIcon = false,
    this.isLoading = false,
    this.height = 50,
    this.width = 200,
    this.gravity = ToastGravity.BOTTOM,
    this.duration = const Duration(seconds: 3),
  });

  void show(BuildContext context) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: textColor,
                strokeWidth: 2.0,
              ),
            )
          else if (isIcon && icon != null)
            Icon(
              icon,
              color: textColor,
            ),
          if ((isIcon && icon != null) || isLoading) const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: textColor, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    // This widget is not directly visible, as `show` is called to display the toast.
    return const SizedBox.shrink();
  }
}

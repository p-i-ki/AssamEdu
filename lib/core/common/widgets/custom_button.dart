import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.backgroungColor,
    required this.textStyle,
    required this.borderSide,
    this.radius = 4,
    this.elevation = 2,
    required this.customFun,
  });
  final String text;
  final Color backgroungColor;

  final TextStyle textStyle;
  final BorderSide borderSide;
  final double radius;
  final double elevation;
  final void Function() customFun;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: customFun,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          side: borderSide,
          backgroundColor: backgroungColor,
          padding: const EdgeInsets.all(8),
        ),
        child: Text(text, style: textStyle));
  }
}

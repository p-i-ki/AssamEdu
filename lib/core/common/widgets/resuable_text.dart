import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText({super.key, required this.text, required this.style});
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: 1,
      textAlign: TextAlign.left,
      softWrap: true,
      overflow: TextOverflow.fade,
    );
  }
}

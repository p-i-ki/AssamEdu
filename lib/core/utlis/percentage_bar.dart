import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PercentageBar extends StatelessWidget {
  final int completedChapters;
  final int totalChapters;

  const PercentageBar(
      {super.key,
      required this.completedChapters,
      required this.totalChapters});

  @override
  Widget build(BuildContext context) {
    // Ensure totalChapters is not zero to avoid division by zero error.
    double percentage =
        totalChapters > 0 ? completedChapters / totalChapters : 0;
    String percentageString = '${(percentage * 100).toStringAsFixed(0)}%';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                percentageString,
                style: TextStyle(fontSize: 12, color: HexColor('134C5D')),
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: percentage,
                    // backgroundColor: const Color.fromARGB(255, 156, 152, 152),
                    backgroundColor: HexColor('134C5D').withOpacity(0.3),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor('134C5D')),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

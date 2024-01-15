import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final Color? bgColor;
  final Color? textColor;
  final String text;
  const CircleContainer({super.key,
    this.bgColor,
    required this.text, this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border:Border.all(
            width: 1.0,
            color: Colors.grey

        ),
        color: bgColor,
      ),
      child: Center(child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color:textColor ),)),
    );
  }
}
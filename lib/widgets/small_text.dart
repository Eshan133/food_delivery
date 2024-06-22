import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  String text;
  double size;
  double height;
  Color color;
  SmallText(
      {Key? key,
      required this.text,
      this.size = 0,
      this.height = 0,
      this.color = const Color(0xFFccc7c5)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? 12 : size,
          height: height == 0 ? 1.2 : height,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400),
    );
  }
}

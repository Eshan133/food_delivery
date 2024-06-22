import 'package:flutter/material.dart';
import 'package:food_delivery_latest/utils/dimension.dart';
import 'package:food_delivery_latest/widgets/small_text.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  IconText(
      {Key? key, required this.icon, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: Dimension.icon24,
        ),
        SizedBox(
          width: Dimension.height5,
        ),
        SmallText(text: text),
      ],
    );
  }
}

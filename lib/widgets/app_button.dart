import 'package:flutter/material.dart';
import 'package:food_delivery_latest/utils/dimension.dart';

class AppButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double iconSize;
  AppButton(
      {Key? key,
      required this.icon,
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.iconColor = const Color(0xFF756d54),
      this.size = 40,
      this.iconSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize == 16 ? Dimension.icon16 : iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}

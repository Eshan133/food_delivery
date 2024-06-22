import 'package:flutter/material.dart';
import 'package:food_delivery_latest/utils/colors.dart';
import 'package:food_delivery_latest/utils/dimension.dart';
import 'package:food_delivery_latest/widgets/big_text.dart';
import 'package:food_delivery_latest/widgets/icon_text.dart';
import 'package:food_delivery_latest/widgets/small_text.dart';

class AppCloumn extends StatelessWidget {
  final String text;
  double size;

  AppCloumn({Key? key, required this.text, this.size = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: size,
        ),
        SizedBox(
          height: Dimension.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                        size: Dimension.icon16,
                      )),
            ),
            SizedBox(
              width: Dimension.width10,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: Dimension.width10,
            ),
            SmallText(text: "1287"),
            SizedBox(
              width: Dimension.height5,
            ),
            SmallText(text: "commments")
          ],
        ),
        SizedBox(
          height: Dimension.height20,
        ),
        Row(
          children: [
            IconText(
              icon: Icons.circle_sharp,
              text: "Normal",
              color: AppColors.iconColor1,
            ),
            SizedBox(
              width: Dimension.width20,
            ),
            IconText(
              icon: Icons.location_on,
              text: "1.2km",
              color: AppColors.mainColor,
            ),
            SizedBox(
              width: Dimension.width20,
            ),
            IconText(
              icon: Icons.access_time_filled_rounded,
              text: "32 min",
              color: AppColors.iconColor2,
            ),
          ],
        )
      ],
    );
  }
}

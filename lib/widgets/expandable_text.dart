import 'package:flutter/material.dart';
import 'package:food_delivery_latest/utils/colors.dart';
import 'package:food_delivery_latest/utils/dimension.dart';
import 'package:food_delivery_latest/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  double textHeight = Dimension.screenHeight / 5.63;

  bool hiddenText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              height: 1.8,
              size: Dimension.font16,
              color: AppColors.paraColor,
            )
          : Container(
              child: Column(
                children: [
                  SmallText(
                    height: 1.8,
                    size: Dimension.font16,
                    color: AppColors.paraColor,
                    text: hiddenText
                        ? (firstHalf + '...')
                        : (firstHalf + secondHalf),
                  ),
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          hiddenText = !hiddenText;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        SmallText(
                          text: hiddenText ? "show more" : "show less",
                          color: AppColors.mainColor,
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

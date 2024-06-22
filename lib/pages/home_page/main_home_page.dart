// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_latest/pages/home_page/body_home_page.dart';
import 'package:food_delivery_latest/widgets/big_text.dart';
import 'package:food_delivery_latest/widgets/small_text.dart';

import '../../utils/colors.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(
            top: 45,
            bottom: 15,
          ),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: "Nepal",
                    color: AppColors.mainColor,
                  ),
                  Row(
                    children: [
                      SmallText(text: "Kathmandu"),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(child: SingleChildScrollView(child: BodyHomePage()))
      ]),
    );
  }
}

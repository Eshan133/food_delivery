import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_latest/routes/routes_helper.dart';
import 'package:food_delivery_latest/utils/dimension.dart';
import 'package:get/get.dart';

import '../../controller/popular_food_controller.dart';
import '../../controller/recommended_food_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  Future<void> _loadResources() async {
    await Get.find<PopularFoodController>().getPopularFoodList();
    await Get.find<RecommendedFoodController>().getRecommendedFoodList();
  }

  @override
  void initState() {
    super.initState();

    _loadResources();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);

    Timer(
      Duration(seconds: 3),
      () => Get.offNamed(
        RouteHelper.getInitial(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/image/logo part 1.png",
                width: Dimension.splashImg,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/image/logo part 2.png",
              width: Dimension.splashImg,
            ),
          )
        ],
      ),
    );
  }
}

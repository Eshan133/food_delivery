import 'package:flutter/material.dart';
import 'package:food_delivery_latest/controller/popular_food_controller.dart';
import 'package:food_delivery_latest/controller/recommended_food_controller.dart';
import 'package:food_delivery_latest/pages/food_page/recommended_food_page.dart';
import 'package:food_delivery_latest/pages/home_page/main_home_page.dart';
import 'package:food_delivery_latest/pages/splash_page/splash_screen.dart';
import 'package:food_delivery_latest/routes/routes_helper.dart';
import 'package:food_delivery_latest/utils/colors.dart';
import 'package:get/get.dart';

import 'controller/cart_controller.dart';
import 'pages/food_page/popular_food_page.dart';
import 'package:food_delivery_latest/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularFoodController>(
      builder: (_) {
        return GetBuilder<RecommendedFoodController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              // home: SplashScreen(),
              initialRoute: RouteHelper.getSplashScreen(),
              getPages: RouteHelper.routes,
            );
          },
        );
      },
    );
  }
}

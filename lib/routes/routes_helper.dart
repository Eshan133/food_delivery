import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery_latest/pages/cart_page/cart_page.dart';
import 'package:food_delivery_latest/pages/home_page/home_page.dart';
import 'package:food_delivery_latest/pages/home_page/main_home_page.dart';
import 'package:food_delivery_latest/pages/splash_page/splash_screen.dart';
import 'package:get/get.dart';

import '../pages/food_page/popular_food_page.dart';
import '../pages/food_page/recommended_food_page.dart';

class RouteHelper {
  static String splashScreen = "/splash-screen";
  static String initial = "/";
  static String popularFood = "/popular-food";
  static String recommendedFood = "/recommended-food";
  static String cartFood = "/cart-food";

  static String getSplashScreen() => '$splashScreen';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartFood() => '$cartFood';

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () {
        return SplashScreen();
      },
    ),
    GetPage(
      name: initial,
      page: () {
        return HomePage();
      },
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];

        return PopularFoodPage(pageId: int.parse(pageId!), page: page!);
      },
    ),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodPage(pageId: int.parse(pageId!), page: page!);
        }),
    GetPage(
        name: cartFood,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn)
  ];
}

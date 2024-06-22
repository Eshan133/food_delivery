import 'package:food_delivery_latest/api/repo/api_client.dart';
import 'package:food_delivery_latest/api/repo/repository/cart_repo.dart';
import 'package:food_delivery_latest/api/repo/repository/popular_food_repo.dart';
import 'package:food_delivery_latest/api/repo/repository/recommended_food_repo.dart';
import 'package:food_delivery_latest/controller/cart_controller.dart';
import 'package:food_delivery_latest/controller/recommended_food_controller.dart';
import 'package:food_delivery_latest/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/popular_food_controller.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repo
  Get.lazyPut(() => PopularFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controller
  Get.lazyPut(() => RecommendedFoodController(recommendedFoodRepo: Get.find()));
  Get.lazyPut(() => PopularFoodController(popularFoodRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}

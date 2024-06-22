import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_latest/base/no_data.dart';
import 'package:food_delivery_latest/controller/cart_controller.dart';
import 'package:food_delivery_latest/controller/popular_food_controller.dart';
import 'package:food_delivery_latest/routes/routes_helper.dart';
import 'package:food_delivery_latest/utils/app_constants.dart';
import 'package:food_delivery_latest/utils/colors.dart';
import 'package:food_delivery_latest/utils/dimension.dart';
import 'package:food_delivery_latest/widgets/app_button.dart';
import 'package:food_delivery_latest/widgets/big_text.dart';
import 'package:food_delivery_latest/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controller/recommended_food_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartController>(
        builder: (controller) {
          var cartList = controller.getItems;
          return Stack(
            children: [
              Positioned(
                top: Dimension.height20 * 3,
                left: Dimension.width20,
                right: Dimension.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      // onTap: () {
                      //   Get.toNamed(
                      //     RouteHelper.getPopularFood()
                      //   )
                      // },
                      child: AppButton(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimension.icon24,
                      ),
                    ),
                    SizedBox(
                      width: Dimension.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppButton(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimension.icon24,
                      ),
                    ),
                    AppButton(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimension.icon24,
                    ),
                  ],
                ),
              ),
              GetBuilder<CartController>(builder: (_cartController) {
                return _cartController.getItems.length > 0
                    ? Positioned(
                        top: Dimension.height20 * 5,
                        left: Dimension.width20,
                        right: Dimension.width20,
                        bottom: 0,
                        child: Container(
                          margin: EdgeInsets.only(top: Dimension.height15),
                          // color: Colors. red,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              itemCount: cartList.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  height: Dimension.height20 * 5,
                                  width: double.maxFinite,
                                  // color: Colors.blue,
                                  margin: EdgeInsets.only(
                                      bottom: Dimension.height10),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex =
                                              Get.find<PopularFoodController>()
                                                  .popularFoodList
                                                  .indexOf(
                                                      cartList[index].product!);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, "Cart"));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedFoodController>()
                                                .recommendedFoodList
                                                .indexOf(
                                                    cartList[index].product!);
                                            if (recommendedIndex >= 0) {
                                              Get.toNamed(RouteHelper
                                                  .getRecommendedFood(
                                                      recommendedIndex,
                                                      "Cart"));
                                            } else {
                                              Get.snackbar(
                                                "History",
                                                "You can't view items from t!",
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                colorText: Colors.white,
                                              );
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: Dimension.height20 * 5,
                                          width: Dimension.height20 * 5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimension.radius20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL +
                                                        "/uploads/" +
                                                        cartList[index].img!),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: Dimension.height20 * 5,
                                          padding: EdgeInsets.only(
                                            left: Dimension.width10,
                                            right: Dimension.width10,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                  text: cartList[index].name!),
                                              SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: controller
                                                        .getItems[index].price!
                                                        .toString(),
                                                    color: Colors.redAccent,
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller.addItems(
                                                                cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .mainBlackColor,
                                                          )),
                                                      SizedBox(
                                                        width:
                                                            Dimension.width10 /
                                                                2,
                                                      ),
                                                      BigText(
                                                          text: cartList[index]
                                                              .quantity!
                                                              .toString()),
                                                      SizedBox(
                                                        width:
                                                            Dimension.width10 /
                                                                2,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller.addItems(
                                                                cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child:
                                                              Icon(Icons.add)),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : NoData(text: "The cart is empty");
              })
            ],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
          return Container(
              height: 120,
              padding: EdgeInsets.only(
                top: Dimension.height30,
                bottom: Dimension.height20,
                left: Dimension.width20,
                right: Dimension.width20,
              ),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimension.radius20 * 2),
                  topRight: Radius.circular(Dimension.radius20 * 2),
                ),
              ),
              child: controller.getItems.length > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: Dimension.height20,
                            bottom: Dimension.height20,
                            left: Dimension.width20,
                            right: Dimension.width20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Dimension.width10 / 2,
                              ),
                              BigText(
                                  text: "\$ " +
                                      controller.totalAmount.toString()),
                              SizedBox(
                                width: Dimension.width10 / 2,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.addToCartHistory();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: Dimension.height20,
                              bottom: Dimension.height20,
                              left: Dimension.width20,
                              right: Dimension.width20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius20),
                              color: AppColors.mainColor,
                            ),
                            child: BigText(
                              text: "Check out",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container());
        },
      ),
    );
  }
}

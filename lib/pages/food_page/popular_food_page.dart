import 'package:flutter/material.dart';
import 'package:food_delivery_latest/controller/popular_food_controller.dart';
import 'package:food_delivery_latest/routes/routes_helper.dart';
import 'package:food_delivery_latest/utils/app_constants.dart';
import 'package:food_delivery_latest/utils/colors.dart';
import 'package:food_delivery_latest/utils/dimension.dart';
import 'package:food_delivery_latest/widgets/app_button.dart';
import 'package:food_delivery_latest/widgets/app_column.dart';
import 'package:food_delivery_latest/widgets/big_text.dart';
import 'package:food_delivery_latest/widgets/expandable_text.dart';
import 'package:get/get.dart';

class PopularFoodPage extends StatelessWidget {
  late int pageId;
  late String page;
  PopularFoodPage({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularFoodController>().popularFoodList[pageId];
    Get.find<PopularFoodController>().initQuantity(product);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<PopularFoodController>(
        builder: (popularFood) {
          return Stack(
            children: [
              Positioned(
                right: 0,
                left: 0,
                child: Container(
                  height: Dimension.height350,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.BASE_URL +
                            "/uploads/" +
                            popularFood.popularFoodList[pageId].img!),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              //buttons
              Positioned(
                top: Dimension.height45,
                right: Dimension.height20,
                left: Dimension.height20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (page == "Cart") {
                            Get.toNamed(RouteHelper.getCartFood());
                          } else {
                            Get.toNamed(RouteHelper.getInitial());
                          }
                        },
                        child: AppButton(icon: Icons.arrow_back_ios)),
                    Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getCartFood());
                              // if (popularFood.totalQuantity > 0) {
                              //   Get.toNamed(RouteHelper.getCartFood());
                              // }
                              // Get.snackbar(
                              //     "Cart count",
                              //     "You should atleast add one item to the cart!",
                              //     backgroundColor: AppColors.mainColor,
                              //     colorText: Colors.white,
                              //   );
                            },
                            child: AppButton(
                                icon: Icons.shopping_cart_checkout_outlined)),
                        popularFood.totalQuantity > 0
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: AppButton(
                                  icon: Icons.circle,
                                  size: 20,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.transparent,
                                ),
                              )
                            : Container(),
                        popularFood.totalQuantity > 0
                            ? Positioned(
                                top: 3,
                                right: 5,
                                child: BigText(
                                  text: popularFood.totalQuantity.toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                      ],
                    )
                  ],
                ),
              ),
              //text body
              Positioned(
                top: Dimension.height350 - Dimension.width20,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimension.width20,
                    left: Dimension.width20,
                    right: Dimension.width20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimension.radius20),
                      topRight: Radius.circular(Dimension.radius20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppCloumn(
                        text: popularFood.popularFoodList[pageId].name!,
                        size: Dimension.font26,
                      ),
                      SizedBox(
                        height: Dimension.height20,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: Dimension.width20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableText(
                              text: popularFood
                                  .popularFoodList[pageId].description!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<PopularFoodController>(
        builder: (popularFood) {
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
            child: Row(
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
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularFood.setQuantitiy(false);
                          },
                          child: Icon(Icons.remove)),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      BigText(text: popularFood.itemInCart.toString()),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      GestureDetector(
                          onTap: () {
                            popularFood.setQuantitiy(true);
                          },
                          child: Icon(Icons.add)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularFood.addItem(popularFood.popularFoodList[pageId]);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimension.height20,
                      bottom: Dimension.height20,
                      left: Dimension.width20,
                      right: Dimension.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text:
                          "\$ ${popularFood.popularFoodList[pageId].price!} | Add to cart",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

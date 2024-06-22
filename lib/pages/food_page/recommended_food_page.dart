import 'package:flutter/material.dart';
import 'package:food_delivery_latest/controller/popular_food_controller.dart';
import 'package:food_delivery_latest/controller/recommended_food_controller.dart';
import 'package:food_delivery_latest/routes/routes_helper.dart';
import 'package:food_delivery_latest/utils/app_constants.dart';
import 'package:food_delivery_latest/utils/colors.dart';
import 'package:food_delivery_latest/utils/dimension.dart';
import 'package:food_delivery_latest/widgets/app_button.dart';
import 'package:food_delivery_latest/widgets/big_text.dart';
import 'package:food_delivery_latest/widgets/expandable_text.dart';
import 'package:get/get.dart';

class RecommendedFoodPage extends StatelessWidget {
  late int pageId;
  late String page;
  RecommendedFoodPage({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommendedFood =
        Get.find<RecommendedFoodController>().recommendedFoodList[pageId];
    Get.find<PopularFoodController>().initQuantity(recommendedFood);
    return GetBuilder<PopularFoodController>(builder: (popularFood) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: 80,
                automaticallyImplyLeading: false,
                title:
                    //icons
                    Row(
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
                        child: AppButton(icon: Icons.clear)),
                    //AppButton(icon: Icons.shopping_cart_outlined)
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartFood());
                        // if (popularFood.totalQuantity > 0) {
                        //   Get.toNamed(RouteHelper.getCartFood());
                        // } else {
                        //   Get.snackbar(
                        //     "Cart count",
                        //     "You should atleast add one item to the cart!",
                        //     backgroundColor: AppColors.mainColor,
                        //     colorText: Colors.white,
                        //   );
                        // }
                      },
                      child: Stack(
                        children: [
                          AppButton(
                              icon: Icons.shopping_cart_checkout_outlined),
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
                      ),
                    )
                  ],
                ),
                //Nepalese Side
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimension.height5,
                      bottom: Dimension.height10,
                    ),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimension.radius20),
                        topRight: Radius.circular(Dimension.radius20),
                      ),
                    ),
                    child: Center(
                        child: BigText(
                      text: recommendedFood.name!,
                      size: Dimension.font26,
                    )),
                  ),
                ),
                //Background
                expandedHeight: 300,
                pinned: true,
                backgroundColor: AppColors.yellowColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    AppConstants.BASE_URL + "/uploads/" + recommendedFood.img!,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //EXPANDABLE TEXT
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: Dimension.width20,
                        right: Dimension.width20,
                      ),
                      child: ExpandableText(text: recommendedFood.description!),
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: GetBuilder<PopularFoodController>(
            builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: Dimension.height10,
                      bottom: Dimension.height10,
                      left: Dimension.width20 * 2.5,
                      right: Dimension.width20 * 2.5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.setQuantitiy(false);
                          },
                          child: AppButton(
                            icon: Icons.remove,
                            iconSize: Dimension.icon24,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                          ),
                        ),
                        BigText(
                          text:
                              "\$ ${recommendedFood.price!} X ${controller.itemInCart}",
                          size: Dimension.font26,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.setQuantitiy(true);
                          },
                          child: AppButton(
                            icon: Icons.add,
                            iconSize: Dimension.icon24,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: Dimension.height30,
                      left: Dimension.height20,
                      right: Dimension.height20,
                      bottom: Dimension.height20,
                    ),
                    height: 120,
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
                            left: Dimension.height20,
                            right: Dimension.height20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.addItem(recommendedFood);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: Dimension.height20,
                              bottom: Dimension.height20,
                              left: Dimension.height20,
                              right: Dimension.height20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius20),
                              color: AppColors.mainColor,
                            ),
                            child: BigText(
                              text: "\$${recommendedFood.price!} | Add to cart",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ));
    });
  }
}

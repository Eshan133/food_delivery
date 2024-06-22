import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_latest/base/no_data.dart';
import 'package:food_delivery_latest/controller/cart_controller.dart';
import 'package:food_delivery_latest/model/cart_model.dart';
import 'package:food_delivery_latest/routes/routes_helper.dart';
import 'package:food_delivery_latest/utils/app_constants.dart';
import 'package:food_delivery_latest/utils/colors.dart';
import 'package:food_delivery_latest/utils/dimension.dart';
import 'package:food_delivery_latest/widgets/big_text.dart';
import 'package:food_delivery_latest/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/app_button.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistory =
        Get.find<CartController>().getCartHistory.reversed.toList();

    Map<String, int> cartItemsPerOrder =
        {}; // map of items length and time they were checked out where time is used as primary key

    for (int i = 0; i < getCartHistory.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistory[i].time)) {
        cartItemsPerOrder.update(getCartHistory[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistory[i].time!, () => 1);
      }
    }

    print("cart item per order is: " + cartItemsPerOrder.toString());

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartItemsTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> orderTimes =
        cartItemsPerOrderToList(); //list of lenght of items order at once

    print("order Times is: " + orderTimes.toString());

    int saveCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();

      if (index < getCartHistory.length) {
        DateTime dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistory[saveCounter].time!);
        var outputFormat = DateFormat("MM-dd-yyyy HH:mm a");
        outputDate = outputFormat.format(dateFormat);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          //Header section
          Container(
            padding: EdgeInsets.only(top: Dimension.height45),
            width: double.maxFinite,
            height: Dimension.height100,
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Food Cart History",
                  color: Colors.white,
                ),
                AppButton(icon: Icons.shopping_cart_outlined)
              ],
            ),
          ),

          //ListView section
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartHistory.length > 0
                ? Expanded(
                    child: Container(
                        margin: EdgeInsets.only(
                          top: Dimension.height20,
                          left: Dimension.width20,
                          right: Dimension.width20,
                        ),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < orderTimes.length; i++)
                                Container(
                                  height: Dimension.height120,
                                  margin: EdgeInsets.only(
                                      bottom: Dimension.height20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timeWidget(saveCounter),
                                      SizedBox(
                                        height: Dimension.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //
                                          //
                                          //image ssection
                                          //
                                          //
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              orderTimes[i],
                                              (index) {
                                                if (saveCounter <
                                                    getCartHistory.length) {
                                                  saveCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: Dimension
                                                                    .width10 /
                                                                2),
                                                        height:
                                                            Dimension.height20 *
                                                                4,
                                                        width:
                                                            Dimension.height20 *
                                                                4,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            Dimension.radius15 /
                                                                                2),
                                                                image:
                                                                    DecorationImage(
                                                                        image:
                                                                            NetworkImage(
                                                                          AppConstants.BASE_URL +
                                                                              "/uploads/" +
                                                                              getCartHistory[saveCounter - 1].img!,
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                      )
                                                    : Container();
                                              },
                                            ),
                                          ),
                                          //
                                          //Total items and add section
                                          //
                                          Container(
                                            height: Dimension.height20 * 4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SmallText(
                                                  text: "Total",
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                  text:
                                                      orderTimes[i].toString() +
                                                          " Items",
                                                  color: AppColors.titleColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var timeOfOrder =
                                                        cartItemsTimeToList();
                                                    Map<int, CartModel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistory
                                                                .length;
                                                        j++) {
                                                      if (getCartHistory[j]
                                                              .time ==
                                                          timeOfOrder[i]) {
                                                        moreOrder.putIfAbsent(
                                                            getCartHistory[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistory[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                            .setCartHistoryItems =
                                                        moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(RouteHelper
                                                        .getCartFood());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimension
                                                                    .width10,
                                                            vertical: Dimension
                                                                    .width10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimension
                                                                  .radius15 /
                                                              3),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .mainColor),
                                                    ),
                                                    child: SmallText(
                                                      text: "one more",
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        )),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: NoData(
                      text: "You havn't purchased anything",
                      imagePath: "assets/image/empty_box.png",
                    ),
                  );
          })
        ],
      ),
    );
  }
}

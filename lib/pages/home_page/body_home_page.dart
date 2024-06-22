import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_latest/controller/popular_food_controller.dart';
import 'package:food_delivery_latest/controller/recommended_food_controller.dart';
import 'package:food_delivery_latest/model/product_model.dart';
import 'package:food_delivery_latest/routes/routes_helper.dart';
import 'package:food_delivery_latest/utils/app_constants.dart';
import 'package:food_delivery_latest/utils/colors.dart';
import 'package:food_delivery_latest/utils/dimension.dart';
import 'package:food_delivery_latest/widgets/app_column.dart';
import 'package:food_delivery_latest/widgets/big_text.dart';
import 'package:food_delivery_latest/widgets/icon_text.dart';
import 'package:food_delivery_latest/widgets/small_text.dart';
import 'package:get/get.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPage = 0.0;
  var _transPage = 0.85;
  var _height = Dimension.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!.toDouble();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //pageview slide scroll
        GetBuilder<PopularFoodController>(builder: (popularFoods) {
          return popularFoods.isLoaded
              ? Container(
                  height: 320,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularFoods.popularFoodList.length,
                    itemBuilder: (context, index) {
                      return _pageItem(
                          index, popularFoods.popularFoodList[index]);
                    },
                  ),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        SizedBox(
          height: Dimension.height5,
        ),

        //dots indicator
        GetBuilder<PopularFoodController>(
          builder: (popularFoods) {
            return popularFoods.isLoaded
                ? DotsIndicator(
                    dotsCount: popularFoods.popularFoodList.length,
                    position: _currentPage,
                    decorator: DotsDecorator(
                      activeColor: AppColors.mainColor,
                      size: Size.square(9.0),
                      activeSize: Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimension.height5),
                      ),
                    ),
                  )
                : DotsIndicator(dotsCount: 1);
          },
        ),
        SizedBox(
          height: Dimension.height30,
        ),

        //recommended details
        Container(
          margin: EdgeInsets.only(left: Dimension.width20),
          child: Row(
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: Dimension.height10),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                  size: Dimension.font26,
                ),
              ),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: SmallText(
                  text: "Food pairing",
                  size: Dimension.font12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimension.height5,
        ),

        //pageView scroll vertical
        GetBuilder<RecommendedFoodController>(
          builder: (recommendedFoods) {
            return recommendedFoods.isLoaded
                ? Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recommendedFoods.recommendedFoodList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getRecommendedFood(
                                  index, "Home"));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: Dimension.width20,
                                  right: Dimension.width20,
                                  bottom: Dimension.height10),
                              child: Row(
                                children: [
                                  Container(
                                    height: Dimension.height120,
                                    width: Dimension.width120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            AppConstants.BASE_URL +
                                                "/uploads/" +
                                                recommendedFoods
                                                    .recommendedFoodList[index]
                                                    .img!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: Dimension.width10,
                                          right: Dimension.width10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BigText(
                                                text: recommendedFoods
                                                    .recommendedFoodList[index]
                                                    .name!),
                                            SizedBox(
                                              height: Dimension.height10,
                                            ),
                                            SmallText(
                                                text: "With Nepalese Side"),
                                            SizedBox(
                                              height: Dimension.height10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconText(
                                                    icon: Icons.circle_rounded,
                                                    text: "Normal",
                                                    color:
                                                        AppColors.iconColor1),
                                                IconText(
                                                    icon: Icons.location_on,
                                                    text: "1.2",
                                                    color: AppColors.mainColor),
                                                IconText(
                                                    icon: Icons
                                                        .access_time_filled_rounded,
                                                    text: "32 min",
                                                    color:
                                                        AppColors.iconColor2),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        )
      ],
    );
  }

  //slide PageView details
  Widget _pageItem(int index, ProductModel popularFoods) {
    Matrix4 matrix4 = Matrix4.identity();

    if (index == _currentPage.floor()) {
      var currentScale = 1 - (_currentPage - index) * (1 - _transPage);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPage.floor() + 1) {
      var currentScale =
          _transPage + (_currentPage - index + 1) * (1 - _transPage);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPage.floor() - 1) {
      var currentScale =
          _transPage + (_currentPage - index - 1) * (1 - _transPage);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = _transPage;
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "Home"));
            },
            child: Container(
              height: Dimension.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimension.width10, right: Dimension.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red,
                image: DecorationImage(
                  image: NetworkImage(
                      AppConstants.BASE_URL + "/uploads/" + popularFoods.img!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimension.width30,
                  right: Dimension.width30,
                  bottom: Dimension.height30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        offset: Offset(0, 5),
                        blurRadius: 5.0),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  ]),
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimension.height15,
                    left: Dimension.height15,
                    right: Dimension.height15),
                child: AppCloumn(text: popularFoods.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_latest/api/repo/repository/popular_food_repo.dart';
import 'package:food_delivery_latest/controller/cart_controller.dart';
import 'package:food_delivery_latest/model/cart_model.dart';
import 'package:food_delivery_latest/model/product_model.dart';
import 'package:food_delivery_latest/utils/colors.dart';
import 'package:get/get.dart';

class PopularFoodController extends GetxController {
  late PopularFoodRepo popularFoodRepo;

  PopularFoodController({required this.popularFoodRepo});

  List<dynamic> _popularFoodList = [];
  List<dynamic> get popularFoodList => _popularFoodList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _itemInCart = 0;
  int get itemInCart => _itemInCart + _quantity;

  var _cart = Get.find<CartController>();

  Future<void> getPopularFoodList() async {
    Response response = await popularFoodRepo.getPopularFoodList();
    if (response.statusCode == 200) {
      _popularFoodList = [];
      _popularFoodList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print("no response");
    }
  }

  void setQuantitiy(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity + 1;
      if ((_quantity + _itemInCart) > 20) {
        Get.snackbar(
          "title count",
          "You can't increase more!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
        _quantity = 20;
      }
    } else {
      _quantity = _quantity - 1;
      if ((_quantity + _itemInCart) < 0) {
        Get.snackbar(
          "title count",
          "You can't reduce more!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );

        _quantity = 0;

        if (_itemInCart > 0) {
          _quantity = -_itemInCart;
        }
      }
    }

    update();
  }

  void initQuantity(ProductModel product) {
    _quantity = 0;
    _itemInCart = 0;

    if (_cart.itemInCart(product)) {
      _itemInCart = _cart.getQuantity(product);
    }

    print("item in cart of id: ${product.id!} is ${_itemInCart}");
  }

  void addItem(ProductModel product) {
    // if ((_quantity + _itemInCart) > 0) {
    _cart.addItems(product, _quantity);
    _quantity = 0;
    _itemInCart = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("Item id is : ${value.id} and quantity is : ${value.quantity}");
    });
    update();
    // } else {
    //   Get.snackbar(
    //     "Quantity",
    //     "You can't add 0 to the cart",
    //     backgroundColor: AppColors.mainColor,
    //     colorText: Colors.white,
    //   );
    // }
  }

  int get totalQuantity {
    return _cart.totalQuantity;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}

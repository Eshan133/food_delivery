import 'dart:convert';

import 'package:food_delivery_latest/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/cart_model.dart';

//CartModel ->> json(MAP) ->> String ** Stores in local storage in string format
//      (jsonEncode calls toJson in CartModel convertng model into string directly)

//String ->> json(MAP) ->> CartModel ** Retrieves dta from local storage to be displayed in CartModel format
//   (jsonDecode)   (ProductModel.fromJson)

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  //storing data in local storage
  void addToCart(List<CartModel> cartList) {
    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);

    cart = [];
    var time = DateTime.now().toString();

    //convert object to String bcz shared preference takes string
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  //retrieving datas from local strorage
  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }

    print("objects in Cart : " + carts.toString());
    List<CartModel> cartList = [];

    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  //Adding cart history to local storage
  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCartList();

    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print("the length of cart history is: ${getCartHistoryList().length}");
  }

  // Removing cart item as the items has been moved to local history
  void removeCartList() {
    sharedPreferences.remove(AppConstants.CART_LIST);
    cart = [];
  }

  //reteriving cart history from local storage
  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  List<CartModel> get getCartHistory {
    return getCartHistoryList();
  }
}

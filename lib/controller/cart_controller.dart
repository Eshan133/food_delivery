import 'package:food_delivery_latest/api/repo/repository/cart_repo.dart';
import 'package:food_delivery_latest/model/product_model.dart';
import 'package:get/get.dart';

import '../model/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItems(ProductModel product, int quantity) {
    if (_items.containsKey(product.id!)) {
      int totalQuantity = 0;
      _items.update(product.id!, (value) {
        print("added item of id : ${product.id} and quanitiy : $quantity");
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            doesExist: true,
            quantity: value.quantity! + quantity,
            time: DateTime.now().toString(),
            product: product);
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          print("added item of id : ${product.id} and quanitiy : $quantity");
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              doesExist: true,
              quantity: quantity,
              time: DateTime.now().toString(),
              product: product);
        });
      }
    }
    cartRepo.addToCart(getItems);
    update();
  }

  bool itemInCart(ProductModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.forEach((key, value) {
        if (key == product.id!) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalQuantity {
    int totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    int total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
    print("the no. of objects are:" + _items.length.toString());
  }

  void addToCartHistory() {
    cartRepo.addToCartHistoryList();

    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> get getCartHistory {
    return cartRepo.getCartHistory;
  }

  set setCartHistoryItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCart(getItems);
    update();
  }
}

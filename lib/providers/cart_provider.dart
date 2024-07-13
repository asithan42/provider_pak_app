import 'package:flutter/material.dart';
import 'package:provider_pak_app/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  //cart item state
  Map<String, CartItem> _items = {};

  //getter
  Map<String, CartItem> get items {
    return {..._items};
  }

  //add item
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (exsistingCartItem) => CartItem(
          id: exsistingCartItem.id,
          title: exsistingCartItem.title,
          price: exsistingCartItem.price,
          quantity: exsistingCartItem.quantity + 1,
        ),
      );
      print("add exsisring data");
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      print("add new data");
    }
    notifyListeners();
  }
}

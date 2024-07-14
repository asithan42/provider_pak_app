import 'package:flutter/material.dart';
import 'package:provider_pak_app/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  //cart item state
  final Map<String, CartItem> _items = {};

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
    }
    notifyListeners();
  }

  //remover items
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  //remove single item from cart
  void removeSingleItem(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (exsistingCartItem) => CartItem(
          id: exsistingCartItem.id,
          title: exsistingCartItem.title,
          price: exsistingCartItem.price,
          quantity: exsistingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}

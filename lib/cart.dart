import 'package:flutter/material.dart';
import 'product.dart';

class Cart with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.price);

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }
}

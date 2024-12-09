import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  void addToCart(CartItem newItem) {
    // Ensure newItem.id is valid
    assert(newItem.id.isNotEmpty, "CartItem id cannot be empty");

    // Check if the item already exists
    final existingIndex = _cartItems.indexWhere((item) => item.id == newItem.id);

    if (existingIndex != -1) {
      // Increase quantity if the item exists
      _cartItems[existingIndex].quantity++;
    } else {
      // Add new item to the cart
      _cartItems.add(newItem);
    }

    notifyListeners();
  }

  void increaseQuantity(String id) {
    final item = _cartItems.firstWhere((cartItem) => cartItem.id == id);
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    final item = _cartItems.firstWhere((cartItem) => cartItem.id == id);
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _cartItems.remove(item);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

}

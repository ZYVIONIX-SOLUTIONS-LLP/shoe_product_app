import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String subtitle;
  final double price;
  final String image;
  final Color bgColor;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.subtitle = '',
    this.bgColor = const Color(0xFFF1F2F6),
    this.quantity = 1,
  });
}

class CartManager extends ChangeNotifier {
  CartManager._internal();
  static final CartManager instance = CartManager._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subTotal =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem(CartItem newItem) {
    final index = _items.indexWhere((i) => i.id == newItem.id);
    if (index != -1) {
      _items[index].quantity += newItem.quantity;
    } else {
      _items.add(newItem);
    }
    notifyListeners();
  }

  void incrementQuantity(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

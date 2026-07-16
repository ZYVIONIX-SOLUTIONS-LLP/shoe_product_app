import 'package:flutter/material.dart';

class WishlistItem {
  final String id;
  final String name;
  final double price;
  final double rating;
  final int reviews;
  final String image;
  final String subtitle;
  final Color bgColor;

  WishlistItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.rating = 0,
    this.reviews = 0,
    this.subtitle = '',
    this.bgColor = const Color(0xFFF1F2F6),
  });
}

class WishlistManager extends ChangeNotifier {
  WishlistManager._internal();
  static final WishlistManager instance = WishlistManager._internal();

  final List<WishlistItem> _items = [];

  List<WishlistItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get itemCount => _items.length;

  bool isFavorite(String id) => _items.any((i) => i.id == id);

  void add(WishlistItem item) {
    if (!isFavorite(item.id)) {
      _items.add(item);
      notifyListeners();
    }
  }

  void remove(String id) {
    _items.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  void toggle(WishlistItem item) {
    if (isFavorite(item.id)) {
      remove(item.id);
    } else {
      add(item);
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

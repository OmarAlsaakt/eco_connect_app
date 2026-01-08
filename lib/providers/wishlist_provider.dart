import 'package:flutter/foundation.dart';
import '../models/product.dart';

class WishlistProvider with ChangeNotifier {
  final List<Product> _wishlistItems = [];

  List<Product> get wishlistItems => _wishlistItems;

  int get itemCount => _wishlistItems.length;

  bool isInWishlist(String productId) {
    return _wishlistItems.any((product) => product.id == productId);
  }

  void addToWishlist(Product product) {
    if (!isInWishlist(product.id)) {
      _wishlistItems.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(String productId) {
    _wishlistItems.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  void toggleWishlist(Product product) {
    if (isInWishlist(product.id)) {
      removeFromWishlist(product.id);
    } else {
      addToWishlist(product);
    }
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }

  List<Product> getWishlistByCategory(String category) {
    return _wishlistItems.where((product) => product.category == category).toList();
  }

  double get totalWishlistValue {
    return _wishlistItems.fold(0.0, (sum, product) => sum + product.price);
  }

  Map<String, int> get categoryCounts {
    Map<String, int> counts = {};
    for (var product in _wishlistItems) {
      counts[product.category] = (counts[product.category] ?? 0) + 1;
    }
    return counts;
  }
}


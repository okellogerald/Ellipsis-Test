import 'product.dart';

class User {
  final List<Product> cartProducts;

  bool hasInCart(Product product) {
    return cartProducts.map((e) => e.id).contains(product.id);
  }

  double get totalAmount => cartProducts.fold(0, (prev, e) => prev + e.price);

  String get getTotalPrice => "\$ $totalAmount";

  User copyWithNewProduct(Product product) {
    return User(cartProducts: List<Product>.from(cartProducts)..add(product));
  }

  const User({
    this.cartProducts = const [],
  });
}

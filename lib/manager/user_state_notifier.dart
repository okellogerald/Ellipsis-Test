import 'package:state_notifier/state_notifier.dart';
import 'package:tunzaa_test/models/user.dart';

import '../models/product.dart';

class UserManager extends StateNotifier<User> {
  UserManager() : super(const User());

  toggle(Product product) {
    if (state.hasInCart(product)) return removeProductFromCart(product);
    addProductToCart(product);
  }

  addProductToCart(Product product) {
    state = state.copyWithNewProduct(product);
    print(state.cartProducts.map((e) => e.title));
  }

  removeProductFromCart(Product product) {
    final cartProducts = List<Product>.from(state.cartProducts);
    cartProducts.removeWhere((e) => e.id == product.id);
    state = User(cartProducts: cartProducts);
  }
}

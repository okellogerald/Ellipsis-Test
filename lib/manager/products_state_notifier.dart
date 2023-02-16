import 'package:state_notifier/state_notifier.dart';
import 'package:tunzaa_test/api/failure.dart';
import 'package:tunzaa_test/models/products_state.dart';

import '../models/product.dart';
import 'products_service.dart';

class ProductsManager extends StateNotifier<ProductsState> {
  final ProductsService service;
  ProductsManager(this.service) : super(const ProductsState.initial());

  List<Product> cache = [];

  void fetchProducts() async {
    if (state.products.isNotEmpty) return;
    state = ProductsState.loading(state.products);
    try {
      final products = await service.fetchAllProducts();
      cache = products;
      state = ProductsState.data(products);
    } on Failure catch (e) {
      state = ProductsState.error(state.products, e);
    }
  }

  void search(String searchText) {
    final results = List<Product>.from(cache)
        .where((e) => e.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    state = ProductsState.data(results);
  }

  void backToAll() {
    state = ProductsState.data(cache);
  }
}

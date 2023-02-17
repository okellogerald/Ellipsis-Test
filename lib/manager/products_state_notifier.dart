import 'package:state_notifier/state_notifier.dart';
import 'package:tunzaa_test/api/failure.dart';
import 'package:tunzaa_test/models/products_state.dart';

import '../models/product.dart';
import 'products_service.dart';

enum SortType {
  priceIncreasing,
  priceDecreasing,
  ratingIncreasing,
  ratingDecreasing
}

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

  void sort(SortType type) {
    final products = List<Product>.from(state.products);

    if (type == SortType.priceDecreasing) {
      products.sort((b, a) => a.price.compareTo(b.price));
    }
    if (type == SortType.priceIncreasing) {
      products.sort((a, b) => a.price.compareTo(b.price));
    }
    if (type == SortType.ratingDecreasing) {
      products.sort((b, a) => a.rating.rate.compareTo(b.rating.rate));
    }
    if (type == SortType.ratingIncreasing) {
      products.sort((a, b) => a.rating.rate.compareTo(b.rating.rate));
    }
    state = ProductsState.data(products);
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

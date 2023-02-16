import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tunzaa_test/models/product.dart';

import '../api/failure.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const ProductsState._();

  const factory ProductsState.initial(
      {@Default(<Product>[]) List<Product> products}) = _Initial;

  const factory ProductsState.loading(List<Product> products) = _Loading;

  const factory ProductsState.data(List<Product> products) = _Data;

  const factory ProductsState.error(
    List<Product> products,
    Failure failure,
  ) = _Error;
}

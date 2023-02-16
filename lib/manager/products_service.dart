import 'package:get_it/get_it.dart';
import 'package:tunzaa_test/api/failure.dart';

import '../models/product.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

const url = "https://fakestoreapi.com/products";

class ProductsService {
  Future<List<Product>> fetchAllProducts() async {
    try {
      final response = await http.get(Uri.parse(url));
      final products = List.from(jsonDecode(response.body));
      return [for (var i in products) Product.fromMap(i)];
    } catch (e, trace) {
      throw Failure.fromAPIError(e, trace);
    }
  }
}

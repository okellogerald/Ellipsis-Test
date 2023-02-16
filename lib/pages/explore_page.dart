import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:tunzaa_test/extensions/context_extension.dart';
import 'package:tunzaa_test/extensions/stateful_widget_extension.dart';
import 'package:tunzaa_test/manager/products_state_notifier.dart';
import 'package:tunzaa_test/pages/product_detail_page.dart';
import 'package:tunzaa_test/theme/theme.dart';
import 'package:tunzaa_test/widgets/image.dart';

import '../theme/colors.dart';
import '../models/product.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with AfterLayoutMixin {
  callback() => context.read<ProductsManager>().fetchProducts();

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    callback();
  }

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      builder: (context, productsState, child) {
        return productsState.maybeWhen(
          loading: (products) => Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: context.colorScheme.primary,
            ),
          ),
          data: (products) {
            return ListView.separated(
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            products[index],
                          ),
                        ),
                      );
                    },
                    child: ProductTile(products[index]));
              },
            );
          },
          error: (products, failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(failure.message),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: callback,
                    child: const Text("Try Again"),
                  )
                ],
              ),
            );
          },
          orElse: () {
            return Container();
          },
        );
      },
      stateNotifier: context.read<ProductsManager>(),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(10).copyWith(right: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 3, spreadRadius: 3)
        ],
        color: context.colorScheme.onPrimary,
      ),
      child: Row(
        children: [
          AppImage(
              image: product.image,
              height: 110,
              width: 120,
              borderRadius: BorderRadius.circular(25)),
          const SizedBox(width: 15),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.title,
                style: context.textTheme.titleLarge?.withSecondaryColor,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 30,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final data = <String>[
                      "\$ ${product.price}",
                      product.rating.rate.toString(),
                    ];
                    final icons = [
                      null,
                      CupertinoIcons.star,
                    ];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          if (icons[index] != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                icons[index],
                                size: 14,
                              ),
                            ),
                          Text(
                            data[index],
                            style: context.textTheme.labelSmall
                                ?.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemCount: 2,
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:tunzaa_test/extensions/context_extension.dart';
import 'package:tunzaa_test/manager/products_state_notifier.dart';
import 'package:tunzaa_test/manager/user_state_notifier.dart';
import 'package:tunzaa_test/models/user.dart';
import 'package:tunzaa_test/theme/theme.dart';

import '../models/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage(this.product, {super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Product get product => widget.product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2),
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style:
                            context.textTheme.headlineSmall?.withSecondaryColor,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<UserManager>().toggle(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Cart action was performed successfully"),
                            ),
                          );
                        },
                        child: StateNotifierBuilder(
                          stateNotifier: context.read<UserManager>(),
                          builder: (context, value, child) {
                            if (value.hasInCart(product)) {
                              return const CircleAvatar(
                                child: Icon(CupertinoIcons.cart_badge_minus),
                              );
                            }
                            return const CircleAvatar(
                              child: Icon(CupertinoIcons.cart_badge_plus),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(product.description),
          const SizedBox(height: 20),
          Text(
            "Product Information",
            style: context.textTheme.titleLarge,
          ),
          const Divider(),
          ProductInformationTile(title: "Price", value: product.getPrice),
          ProductInformationTile(title: "Rate", value: product.getRate),
          ProductInformationTile(title: "Category", value: product.category),
        ],
      ),
    );
  }
}

class ProductInformationTile extends StatelessWidget {
  final String title, value;
  const ProductInformationTile(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        value,
        style:
            context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

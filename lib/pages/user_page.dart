import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:tunzaa_test/theme/colors.dart';
import 'package:tunzaa_test/pages/explore_page.dart';
import 'package:tunzaa_test/extensions/context_extension.dart';
import 'package:tunzaa_test/manager/user_state_notifier.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserManager get manager => context.watch<UserManager>();

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
        stateNotifier: context.read<UserManager>(),
        builder: (context, user, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Account"),
              centerTitle: false,
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.getTotalPrice,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: user.cartProducts.isEmpty
                ? const Center(
                    child: Text("Your cart is empty"),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (_, index) {
                      return Row(
                        children: [
                          Expanded(
                              child: ProductTile(user.cartProducts[index])),
                          GestureDetector(
                              onTap: () {
                                context
                                    .read<UserManager>()
                                    .toggle(user.cartProducts[index]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Cart action was performed successfully"),
                                  ),
                                );
                              },
                              child: const CircleAvatar(
                                child: Icon(CupertinoIcons.cart_badge_minus),
                              )),
                          const SizedBox(width: 15),
                        ],
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemCount: user.cartProducts.length,
                  ),
          );
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunzaa_test/manager/products_state_notifier.dart';

import 'textfield.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final isSearchingNotifier = ValueNotifier(false);
  final controller = TextEditingController();

  ProductsManager get manager => context.read<ProductsManager>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: isSearchingNotifier,
                    builder: (context, isSearching, _) {
                      return AppTextField(
                        controller: controller,
                        hintText: "Search for products",
                        inputDecoration:
                            AppTextField.defaultDecoration.copyWith(
                          suffixIcon: isSearching
                              ? TextButton(
                                  onPressed: () {
                                    controller.clear();
                                    manager.backToAll();
                                    isSearchingNotifier.value = false;
                                  },
                                  child: const Icon(Icons.close))
                              : const Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          manager.search(value.trim());
                          isSearchingNotifier.value = value.trim().isNotEmpty;
                        },
                      );
                    }),
              ),
              const SizedBox(width: 15),
              CircleAvatar(
                child: IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(CupertinoIcons.line_horizontal_3_decrease)),
              )
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

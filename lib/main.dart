import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'manager/products_service.dart';
import 'manager/products_state_notifier.dart';
import 'manager/user_state_notifier.dart';
import 'models/products_state.dart';
import 'models/user.dart';

void main() {
  GetIt.I.registerSingleton<ProductsService>(ProductsService());

  runApp(
    MultiProvider(
      providers: [
        StateNotifierProvider<ProductsManager, ProductsState>(
          create: (context) => ProductsManager(GetIt.I.get<ProductsService>()),
        ),
        StateNotifierProvider<UserManager, User>(
          create: (context) => UserManager(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

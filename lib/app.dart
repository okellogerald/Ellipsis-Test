import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tunzaa_test/manager/products_service.dart';
import 'package:tunzaa_test/manager/products_state_notifier.dart';
import 'package:tunzaa_test/manager/user_state_notifier.dart';
import 'package:tunzaa_test/models/products_state.dart';
import 'package:tunzaa_test/models/user.dart';

import 'pages/home_page.dart';
import 'theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

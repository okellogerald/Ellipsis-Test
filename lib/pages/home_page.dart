import 'package:flutter/material.dart';
import 'package:tunzaa_test/pages/explore_page.dart';
import 'package:tunzaa_test/extensions/context_extension.dart';
import 'package:tunzaa_test/widgets/search_bar.dart';
import 'package:tunzaa_test/pages/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.mediaQuery.padding.top + 30),
            child: Column(
              children: const [
                SearchBar(),
                Expanded(child: ExplorePage()),
              ],
            ),
          ),
          const UserPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My Account",
          ),
        ],
      ),
    );
  }
}

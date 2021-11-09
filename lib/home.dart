import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalz/models/models.dart';
import 'package:rentalz/screens/home_screen.dart';
import 'package:rentalz/screens/property_screen.dart';
import 'models/managers/managers.dart';
import 'screens/search_screen.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _selectedIndex = 0;

  static List<Widget> screens = [
    const HomeScreen(),
    const PropertyScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Rental Z',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: tabManager.selectedTab == 1
              ? [
                  IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () {},
                  ),
                ]
              : null,
        ),
        body: IndexedStack(
          index: tabManager.selectedTab,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: tabManager.selectedTab,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
          onTap: (index) {
            setState(() {
              tabManager.goToTab(index);
            });
          },
        ),
      );
    });
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalz/components/components.dart';
import 'package:rentalz/components/custom_dropdown.dart';
import 'package:rentalz/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sql_helper.dart';
import 'property_item_screen.dart';
import 'property_list_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const String prefSearchKey = 'prefSearch';
  late TextEditingController searchTextController;

  List currentSearchList = [];

  List<String> previousSearches = <String>[];

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void savePreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList(prefSearchKey, previousSearches);
  }

  void getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(prefSearchKey)) {
      final searches = prefs.getStringList(prefSearchKey);

      if (searches != null) {
        previousSearches = searches;
      } else {
        previousSearches = <String>[];
      }

      prefs.setStringList(prefSearchKey, previousSearches);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSearchCard(),
            // _buildRentalLoader(context),
            // _buildFilterScreen(),
            // Listview PropertyTile(manager.propertyitem.id)
            const SizedBox(height: 12.0),
            _buildSearchResults(searchTextController.text),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4.0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration(border: InputBorder.none, hintText: 'Search'),
                    autofocus: false,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      if (!previousSearches.contains(value)) {
                        previousSearches.add(value);
                        savePreviousSearches();
                      }
                    },
                    controller: searchTextController,
                  )),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    onSelected: (String value) {
                      searchTextController.text = value;
                      startSearch(searchTextController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      return previousSearches.map<CustomDropdownMenuItem<String>>((String value) {
                        return CustomDropdownMenuItem<String>(
                          text: value,
                          value: value,
                          callback: () {
                            setState(() {
                              previousSearches.remove(value);
                              Navigator.pop(context);
                            });
                          },
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),

            // PopupMenuButton(
            //   icon: const Icon(
            //     Icons.arrow_drop_down,
            //     color: Colors.grey,
            //   ),
            //   onSelected: (String value) {
            //     searchTextController.text = value;
            //     startSearch(searchTextController.text);
            //   },
            //   itemBuilder: (BuildContext context) {
            //     return previousSearches.map((String value) {
            //       return CustomDropdownMenuItem(
            //           value: value,
            //           text: value,
            //           callback: () {
            //             setState(() {
            //               previousSearches.remove(value);
            //               Navigator.pop(context);
            //             });
            //           });
            //     }).toList();
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  void startSearch(String value) {
    setState(() {
      currentSearchList.clear();

      value = value.trim();

      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  Widget _buildSearchResults(String query) {
    return Consumer<PropertyManager>(
      builder: (BuildContext context, manager, Widget? child) {
        // final searchedPropertyItems = manager.searchProperty(query);
        manager.refreshProperties();
        List<PropertyItem> searchedItems = manager.searchProperty(query);

        return SizedBox(
          height: 600,
          child: ListView.separated(
              itemBuilder: (context, index) {
                final property = searchedItems[index];
                return Dismissible(
                  key: Key(property.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  onDismissed: (direction) async {
                    manager.deleteProperty(searchedItems[index].id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${property.name} dismissed')),
                    );
                    // await SQLHelper.getItems();
                  },
                  child: InkWell(
                    child: PropertyTile(
                      key: Key(property.id),
                      property: property,
                      onComplete: (change) {
                        if (change != null) {
                          manager.completeProperty(property, index, change);
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyItemScreen(
                            originalItem: property,
                            onCreate: (property) {},
                            onUpdate: (property) {
                              manager.updateProperty(property, index);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16.0);
              },
              itemCount: searchedItems.length),
        );
      },
    );
  }
}

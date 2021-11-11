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
  final ScrollController _scrollController = ScrollController();
  List currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;

  List<String> previousSearches = <String>[];

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: '');
    _scrollController.addListener(() {
      final triggerFetchMoreSize = 0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (hasMore && currentEndPosition < currentCount && !loading && !inErrorState) {
          setState(() {
            loading = true;
            currentStartPosition = currentEndPosition;
            currentEndPosition = min(currentStartPosition + pageCount, currentCount);
          });
        }
      }
    });
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
            // Expanded(
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           controller: searchTextController,
            //           decoration:
            //               const InputDecoration(border: InputBorder.none, hintText: 'Search'),
            //           autofocus: false,
            //           textInputAction: TextInputAction.done,
            //           onSubmitted: (value) {
            //             if (!previousSearches.contains(value)) {
            //               previousSearches.add(value);
            //               savePreviousSearches();
            //             }
            //           },
            //         ),
            //       ),
            //       DropdownButton<String>(
            //         value: searchTextController.text,
            //         icon: const Icon(
            //           Icons.arrow_downward,
            //           color: Colors.blue,
            //         ),
            //         iconSize: 20,
            //         elevation: 16,
            //         style: const TextStyle(color: Colors.blue),
            //         underline: Container(
            //           height: 2,
            //           color: Colors.blue,
            //         ),
            //         isExpanded: true,
            //         onChanged: (String? newValue) {
            //           setState(() {
            //             searchTextController.text = newValue!;
            //           });
            //         },
            //         items: currentSearchList.map<DropdownMenuItem<String>>((String value) {
            //           return DropdownMenuItem<String>(
            //             value: value,
            //             child: Text(value),
            //           );
            //         }).toList(),
            //       ),
            //     ],
            //   ),
            // ),

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
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();

      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  // Widget _buildRentalCard(BuildContext topLevelContext, List<APIHits> hits, int index) {
  //   final rental = hits[index].rental;
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(topLevelContext, MaterialPageRoute(
  //         builder: (context) {
  //           return const RentalDetails();
  //         },
  //       ));
  //     },
  //     child: rentalStringCard(rental.image, rental.label),
  //   );
  // }

  // Widget _buildFilterScreen() {
  //   return Consumer<PropertyManager>(
  //     builder: (BuildContext context, manager, Widget? child) {
  //       final propertyItems = manager.propertyItems;

  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: ListView.separated(
  //             itemBuilder: (context, index) {
  //               final property = propertyItems[index];
  //               return Dismissible(
  //                 key: Key(property.id),
  //                 direction: DismissDirection.endToStart,
  //                 background: Container(
  //                   color: Colors.red,
  //                   alignment: Alignment.centerRight,
  //                   child: Icon(
  //                     Icons.delete_forever,
  //                     color: Colors.white,
  //                     size: 50.0,
  //                   ),
  //                 ),
  //                 onDismissed: (direction) async {
  //                   manager.deleteProperty(index);
  //                   await SQLHelper.deleteItem(index);
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(content: Text('${property.name} dismissed')),
  //                   );
  //                   await SQLHelper.getItems();
  //                 },
  //                 child: InkWell(
  //                   child: PropertyTile(
  //                     key: Key(property.id),
  //                     property: property,
  //                     onComplete: (change) {
  //                       if (change != null) {
  //                         manager.completeProperty(index, change);
  //                       }
  //                     },
  //                   ),
  //                   onTap: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => PropertyItemScreen(
  //                           originalItem: property,
  //                           onCreate: (property) {},
  //                           onUpdate: (property) {
  //                             manager.updateProperty(property, index);
  //                             Navigator.pop(context);
  //                           },
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               );
  //             },
  //             separatorBuilder: (context, index) {
  //               return const SizedBox(height: 16.0);
  //             },
  //             itemCount: propertyItems.length),
  //       );
  //     },
  //   );
  // }
}

import 'package:flutter/material.dart';
import 'package:rentalz/models/property_item.dart';

import '../../sql_helper.dart';

class PropertyManager extends ChangeNotifier {
  final List<PropertyItem> _propertyItems = <PropertyItem>[];
  // late List<PropertyItem> _searchedItems = [];

  bool isLoading = true;

  // This function is used to fetch all data from the database
  void refreshProperties() async {
    final items = await SQLHelper.getItems();
    _propertyItems.clear();
    for (var item in items) {
      _propertyItems.add(PropertyItem.fromJson(item));
    }
    isLoading = false;
  }

  List<PropertyItem> get propertyItems => List.unmodifiable(_propertyItems);
  // List<PropertyItem> get searchedItems => List.unmodifiable(_searchedItems);

  // void deleteProperty(int index) {
  //   _propertyItems.removeAt(index);
  //   notifyListeners();
  // }

  // void addProperty(PropertyItem item) {
  //   _propertyItems.add(item);
  //   notifyListeners();
  // }

  // void updateProperty(PropertyItem item, int index) {
  //   _propertyItems[index] = item;
  //   notifyListeners();
  // }

  // void completeProperty(int index, bool change) {
  //   final item = _propertyItems[index];
  //   _propertyItems[index] = item.copyWith(rented: change);
  //   notifyListeners();
  // }

  // void deleteProperty(int index) {
  //   _propertyItems.removeAt(index);
  //   notifyListeners();
  // }

  Future<void> addProperty(PropertyItem item) async {
    _propertyItems.add(item);
    notifyListeners();
    await SQLHelper.createItem(item
        // item.id,
        // item.name,
        // item.address,
        // item.type,
        // item.furniture!,
        // item.bedrooms,
        // item.price,
        // item.date,
        // item.reporter,
        // item.rented,
        );
    // _refreshProperties();
    // await SQLHelper.getItems();
  }

  Future<void> updateProperty(PropertyItem item, int index) async {
    _propertyItems[index] = item;

    notifyListeners();
    await SQLHelper.updateItem(item);
    // _refreshProperties();
  }

  Future<void> completeProperty(PropertyItem item, int index, bool change) async {
    // final item = _propertyItems[index];
    // final index = _propertyItems.indexWhere((propertyId) => propertyId.id == item.id);
    _propertyItems[index] = item.copyWith(rented: change);

    await SQLHelper.updateItem(item
        // _propertyItems[index].id,
        // _propertyItems[index].name,
        // _propertyItems[index].address,
        // _propertyItems[index].type,
        // _propertyItems[index].furniture!,
        // _propertyItems[index].bedrooms,
        // _propertyItems[index].price,
        // _propertyItems[index].date,
        // _propertyItems[index].reporter,
        // _propertyItems[index].rented,
        );

    notifyListeners();

    // _refreshProperties();
  }

  Future<void> deleteProperty(String index) async {
    _propertyItems.removeWhere((item) => item.id == index);
    await SQLHelper.deleteItem(index);
    notifyListeners();
  }

  // Future<void> searchProperty(String query) async {
  //   final items = await SQLHelper.searchItem(query);
  //   notifyListeners();
  //   _searchedItems = items.map((item) => PropertyItem.fromJson(item)).toList();
  // }

  List<PropertyItem> searchProperty(String query) {
    final searched = _propertyItems
        .where((item) =>
            RegExp('^.*$query.*', caseSensitive: false).hasMatch(item.name) ||
            RegExp('^.*$query.*', caseSensitive: false).hasMatch(item.address) ||
            RegExp('^.*$query.*', caseSensitive: false).hasMatch(item.city) ||
            RegExp('^.*$query.*', caseSensitive: false).hasMatch(item.district) ||
            RegExp('^.*$query.*', caseSensitive: false).hasMatch(item.ward) ||
            RegExp('^.*$query.*', caseSensitive: false).hasMatch(item.type.toString()) ||
            RegExp('^.*$query.*', caseSensitive: false).hasMatch(item.furniture.toString()) ||
            RegExp('^.*$query.*', caseSensitive: false).hasMatch(item.reporter) ||
            RegExp('^.*$query.*', caseSensitive: false).hasMatch(item.notes!))
        .toList();
    return searched;
  }
}

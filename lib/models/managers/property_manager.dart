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

  Future<void> addProperty(PropertyItem item) async {
    _propertyItems.add(item);
    notifyListeners();
    await SQLHelper.createItem(item);
  }

  Future<void> updateProperty(PropertyItem item, int index) async {
    _propertyItems[index] = item;

    notifyListeners();
    await SQLHelper.updateItem(item);
  }

  Future<void> completeProperty(PropertyItem item, int index, bool change) async {
    _propertyItems[index] = item.copyWith(rented: change);

    await SQLHelper.updateItem(item);
    notifyListeners();
  }

  Future<void> deleteProperty(String index) async {
    _propertyItems.removeWhere((item) => item.id == index);
    await SQLHelper.deleteItem(index);
    notifyListeners();
  }

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
}

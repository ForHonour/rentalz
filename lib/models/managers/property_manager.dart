import 'package:flutter/material.dart';
import 'package:rentalz/models/property_item.dart';

import '../../sql_helper.dart';

class PropertyManager extends ChangeNotifier {
  List<PropertyItem> _propertyItems = <PropertyItem>[];

  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshProperties() async {
    final items = await SQLHelper.getItems();
    _propertyItems.clear();
    for (var item in items) {
      _propertyItems.add(PropertyItem.fromJson(item));
    }
    _isLoading = false;
  }

  List<PropertyItem> get propertyItems => List.unmodifiable(_propertyItems);

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
    await SQLHelper.updateItem(item
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
}

import 'package:flutter/material.dart';
import 'package:rentalz/models/property_item.dart';

import '../../sql_helper.dart';

class PropertyManager extends ChangeNotifier {
  final _propertyItems = <PropertyItem>[];

  List<PropertyItem> get propertyItems => List.unmodifiable(_propertyItems);

  void deleteProperty(int index) {
    _propertyItems.removeAt(index);
    notifyListeners();
  }

  void addProperty(PropertyItem item) {
    _propertyItems.add(item);
    notifyListeners();
  }

  // Future<void> addProperty(PropertyItem item) async {
  //   _propertyItems.add(item);
  //   notifyListeners();
  //   await SQLHelper.createItem(
  //     item.name,
  //     item.address,
  //     item.type,
  //     item.furniture!,
  //     item.bedrooms,
  //     item.price,
  //     item.date,
  //     item.reporter,
  //     item.rented,
  //   );
  //   await SQLHelper.getItems();
  // }

  void updateProperty(PropertyItem item, int index) {
    _propertyItems[index] = item;
    notifyListeners();
  }

  void completeProperty(int index, bool change) {
    final item = _propertyItems[index];
    _propertyItems[index] = item.copyWith(rented: change);
    notifyListeners();
  }
}

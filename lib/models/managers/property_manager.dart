import 'package:flutter/material.dart';
import 'package:rentalz/models/property_item.dart';

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

  void updateProperty(PropertyItem item, int index) {
    _propertyItems[index] = item;
    notifyListeners();
  }

  void completeProperty(int index, bool change) {
    final item = _propertyItems[index];
    _propertyItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}

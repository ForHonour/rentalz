// import 'package:flutter/painting.dart';
import 'package:json_annotation/json_annotation.dart';

enum PropertyType {
  house,
  apartment,
  office,
}

enum FurnitureType {
  unfurnished,
  halfFurnished,
  furnished,
}

// @JsonSerializable()
class PropertyItem {
  final String id;
  final String name;
  final List<String> address;
  final PropertyType type;
  final FurnitureType? furniture;
  final int bedrooms;
  final int price;
  final DateTime date;
  final String reporter;
  final bool rented;
  final List<String>? notes;

  const PropertyItem({
    required this.id,
    required this.name,
    required this.address,
    required this.type,
    this.furniture,
    required this.bedrooms,
    required this.date,
    required this.reporter,
    required this.price,
    this.notes,
    this.rented = false,
  });
  // String get propertyType => describeEnum(property_type);
  // String get assetname => 'assets/images/$id-$propertyType.jpg';

  // @override
  // String toString() {
  //   // return "$property_name (id=$id)";
  // }

  PropertyItem copyWith({
    String? id,
    String? propertyName,
    List<String>? propertyAddress,
    PropertyType? propertyType,
    FurnitureType? furnitureType,
    int? numberOfBedrooms,
    int? price,
    DateTime? date,
    String? nameOfReporter,
    List<String>? notes,
    bool? rented,
  }) {
    return PropertyItem(
      id: id ?? this.id,
      name: propertyName ?? this.name,
      address: propertyAddress ?? this.address,
      type: propertyType ?? this.type,
      furniture: furnitureType ?? this.furniture,
      bedrooms: numberOfBedrooms ?? this.bedrooms,
      price: price ?? this.price,
      date: date ?? this.date,
      reporter: nameOfReporter ?? this.reporter,
      notes: notes ?? this.notes,
      rented: rented ?? this.rented,
    );
  }
}

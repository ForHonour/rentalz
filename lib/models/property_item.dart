// import 'package:flutter/painting.dart';

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

class PropertyItem {
  final String id;
  final String name;
  final List<String> address;
  final PropertyType type;
  final FurnitureType? furniture;
  final int numberOfBedrooms;
  final int price;
  final DateTime date;
  final String nameOfReporter;
  final String? notes;
  final bool isInUse;

  const PropertyItem({
    required this.id,
    required this.name,
    required this.address,
    required this.type,
    this.furniture,
    required this.numberOfBedrooms,
    required this.date,
    required this.nameOfReporter,
    required this.price,
    this.notes,
    this.isInUse = false,
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
    String? notes,
    bool? isInUse,
  }) {
    return PropertyItem(
      id: id ?? this.id,
      name: propertyName ?? this.name,
      address: propertyAddress ?? this.address,
      type: propertyType ?? this.type,
      furniture: furnitureType ?? this.furniture,
      numberOfBedrooms: numberOfBedrooms ?? this.numberOfBedrooms,
      price: price ?? this.price,
      date: date ?? this.date,
      nameOfReporter: nameOfReporter ?? this.nameOfReporter,
      notes: notes ?? this.notes,
      isInUse: isInUse ?? this.isInUse,
    );
  }
}

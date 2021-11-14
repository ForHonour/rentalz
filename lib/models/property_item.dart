// import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
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

  factory PropertyItem.fromJson(Map<String, dynamic> json) {
    PropertyType propertyType;
    FurnitureType furnitureType;

    if (json['type'] == 'apartment') {
      propertyType = PropertyType.apartment;
    } else if (json['type'] == 'house') {
      propertyType = PropertyType.house;
    } else {
      propertyType = PropertyType.office;
    }

    if (json['furniture'] == 'unfurnished') {
      furnitureType = FurnitureType.unfurnished;
    } else if (json['furniture'] == FurnitureType.halfFurnished) {
      furnitureType = FurnitureType.halfFurnished;
    } else {
      furnitureType = FurnitureType.furnished;
    }

    return PropertyItem(
      id: json['id'],
      name: json['name'],
      address: json['address'].split(',').toList(),
      type: propertyType,
      furniture: furnitureType,
      bedrooms: json['bedrooms'],
      price: json['rented'],
      date: DateTime.parse(json['date']),
      reporter: json['reporter'],
      rented: json['rented'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address.join(', '),
      'type': type,
      'furniture': furniture,
      'bedrooms': bedrooms,
      'price': price,
      'date': DateFormat('MMMM dd h:mm a').format(date),
      'reporter': reporter,
      'rented': rented == false ? 0 : 1,
    };
  }
}

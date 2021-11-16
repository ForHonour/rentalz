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
  final String address;
  final String city;
  final String district;
  final String ward;
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
    required this.city,
    required this.district,
    required this.ward,
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
    String? name,
    String? address,
    // List<String>? propertyAddress,
    String? city,
    String? district,
    String? ward,
    PropertyType? type,
    FurnitureType? furniture,
    int? bedrooms,
    int? price,
    DateTime? date,
    String? reporter,
    List<String>? notes,
    bool? rented,
  }) {
    return PropertyItem(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      type: type ?? this.type,
      furniture: furniture ?? this.furniture,
      bedrooms: bedrooms ?? this.bedrooms,
      price: price ?? this.price,
      date: date ?? this.date,
      reporter: reporter ?? this.reporter,
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
      address: json['address'],
      city: json['city'],
      district: json['district'],
      ward: json['ward'],
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
      'address': address,
      'city': city,
      'district': district,
      'ward': ward,
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

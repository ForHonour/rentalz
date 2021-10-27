// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rentalz/models/property_item.dart';

class PropertyTile extends StatelessWidget {
  final PropertyItem property;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;

  PropertyTile({
    Key? key,
    required this.property,
    this.onComplete,
  })  : textDecoration = property.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildColor(),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  child: Text(
                    property.name,
                    style: GoogleFonts.lato(
                      decoration: textDecoration,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            buildFurnitureType(),
                            const SizedBox(width: 4.0),
                            buildPropertyType(),
                          ],
                        ),
                        Text(
                          property.numberOfBedrooms.toString() + ' bedrooms',
                          style: GoogleFonts.lato(
                            decoration: textDecoration,
                            fontSize: 16.0,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              property.address.elementAt(2),
                              style: GoogleFonts.lato(
                                decoration: textDecoration,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(width: 3.0),
                            Text(
                              property.address.last,
                              style: GoogleFonts.lato(
                                decoration: textDecoration,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        buildDate(),
                      ],
                    ),
                    // const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          '\$' + property.price.toString() + '/mo',
                          style: GoogleFonts.lato(
                            decoration: textDecoration,
                            fontSize: 16.0,
                          ),
                        ),
                        buildCheckbox(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildColor() {
    Color _colorType = Colors.black;
    if (property.type == PropertyType.apartment) {
      _colorType = Colors.purple;
    } else if (property.type == PropertyType.house) {
      _colorType = Colors.green;
    } else if (property.type == PropertyType.office) {
      _colorType = Colors.blue;
    }
    return Container(
      width: 5.0,
      color: _colorType,
    );
  }

  Widget buildFurnitureType() {
    if (property.furniture == FurnitureType.unfurnished) {
      return Text(
        'Unfurnished',
        style: GoogleFonts.lato(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          decoration: textDecoration,
        ),
      );
    } else if (property.furniture == FurnitureType.halfFurnished) {
      return Text(
        'Half-furnished',
        style: GoogleFonts.lato(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          decoration: textDecoration,
        ),
      );
    } else if (property.furniture == FurnitureType.furnished) {
      return Text(
        'Furnished',
        style: GoogleFonts.lato(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          decoration: textDecoration,
        ),
      );
    } else {
      throw Exception('This PropertyType type does not exist');
    }
  }

  Widget buildPropertyType() {
    if (property.type == PropertyType.office) {
      return Text(
        'Office',
        style: GoogleFonts.lato(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          decoration: textDecoration,
        ),
      );
    } else if (property.type == PropertyType.apartment) {
      return Text(
        'Apartment',
        style: GoogleFonts.lato(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          decoration: textDecoration,
        ),
      );
    } else if (property.type == PropertyType.house) {
      return Text(
        'House',
        style: GoogleFonts.lato(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          decoration: textDecoration,
        ),
      );
    } else {
      throw Exception('This PropertyType type does not exist');
    }
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(property.date);
    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration),
    );
  }

  Widget buildCheckbox() {
    return Checkbox(
      value: property.isComplete,
      onChanged: onComplete,
    );
  }
}

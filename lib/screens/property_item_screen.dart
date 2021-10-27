import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentalz/components/property_tile.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:rentalz/theme/rentalz_color.dart';
import 'package:rentalz/theme/rentalz_color.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class PropertyItemScreen extends StatefulWidget {
  final Function(PropertyItem) onCreate;
  final Function(PropertyItem) onUpdate;
  final PropertyItem? originalItem;
  final bool isUpdating;

  const PropertyItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _PropertyItemScreenState createState() => _PropertyItemScreenState();
}

class _PropertyItemScreenState extends State<PropertyItemScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberOfBedroomsController = TextEditingController();
  final _priceController = TextEditingController();

  String _name = 'No Name';
  List<String> _address = ['No Address', '', '', ''];
  String _addressNumber = '';
  String _dropdownCityValue = 'Select City';
  String _dropdownDistrictValue = 'Select District';
  String _dropdownWardValue = 'Select Ward';
  PropertyType _propertyType = PropertyType.apartment;
  FurnitureType _furnitureType = FurnitureType.unfurnished;
  DateTime _dateAdded = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  // Color _currentColor = Colors.green;
  int _currentNumberOfBedroomsValue = 0;
  int _currentPriceValue = 0;

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _address = originalItem.address;
      _currentNumberOfBedroomsValue = originalItem.numberOfBedrooms;
      _currentPriceValue = originalItem.price;
      _propertyType = originalItem.type;
      _furnitureType = originalItem.furniture!;
      // _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dateAdded = date;
    }

    @override
    void dispose() {
      _nameController.dispose();
      super.dispose();
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    _addressController.addListener(() {
      setState(() {
        _addressNumber = _addressController.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final propertyItem = PropertyItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                address: [
                  _addressController.text,
                  _dropdownWardValue,
                  _dropdownDistrictValue,
                  _dropdownCityValue,
                ],
                type: _propertyType,
                furniture: _furnitureType,
                // color: _currentColor,
                numberOfBedrooms: _currentNumberOfBedroomsValue,
                price: _currentPriceValue,
                date: DateTime(
                  _dateAdded.year,
                  _dateAdded.month,
                  _dateAdded.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),

                nameOfReporter: 'Khang',
              );
              if (widget.isUpdating) {
                widget.onUpdate(propertyItem);
              } else {
                widget.onCreate(propertyItem);
              }
            },
          ),
        ],
        elevation: 0.0,
        title: Text(
          'Property Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            const SizedBox(height: 10.0),
            buildAddressField(),
            const SizedBox(height: 10.0),
            buildPropertyTypeField(),
            const SizedBox(height: 10.0),
            buildFurnitureTypeField(),
            const SizedBox(height: 10.0),
            buildNumberOfBedroomsField(),
            buildPriceField(),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildDateField(context),
                SizedBox(width: 50),
                buildTimeField(context),
              ],
            ),
            const SizedBox(height: 10.0),
            PropertyTile(
              property: PropertyItem(
                id: 'previewMode',
                name: _name,
                type: _propertyType,
                furniture: _furnitureType,
                address: [
                  _addressController.text,
                  _dropdownWardValue,
                  _dropdownDistrictValue,
                  _dropdownCityValue,
                ],
                // color: _currentColor,
                numberOfBedrooms: _currentNumberOfBedroomsValue,
                date: DateTime(
                  _dateAdded.year,
                  _dateAdded.month,
                  _dateAdded.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),

                nameOfReporter: '',
                price: _currentPriceValue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Property Name',
          style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: _nameController,
          // cursorColor: _currentColor,

          decoration: InputDecoration(
            hintText: 'E.g. Đại Nam, Thuỷ Tề ...',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        )
      ],
    );
  }

  Widget buildAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Property Address',
          style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: _addressController,
          // cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. 543 Hồng Bàng St.',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 70,
              child: Text(
                'City: ',
                style: GoogleFonts.lato(fontSize: 18.0),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 250,
              child: DropdownButton<String>(
                value: _dropdownCityValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.blue,
                ),
                iconSize: 20,
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownCityValue = newValue!;
                  });
                },
                items: <String>['Select City', 'One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 70,
              child: Text(
                'District: ',
                style: GoogleFonts.lato(fontSize: 18.0),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 250,
              child: DropdownButton<String>(
                value: _dropdownDistrictValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.blue,
                ),
                iconSize: 20,
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownDistrictValue = newValue!;
                  });
                },
                items: <String>['Select District', 'One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 70,
              child: Text(
                'Ward: ',
                style: GoogleFonts.lato(fontSize: 18.0),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 250,
              child: DropdownButton<String>(
                value: _dropdownWardValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.blue,
                ),
                iconSize: 20,
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownWardValue = newValue!;
                  });
                },
                items: <String>['Select Ward', 'One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPropertyTypeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Property Type',
          style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              label: Text(
                'apartment',
                style: _propertyType == PropertyType.apartment
                    ? kRentalZChipOnSelectedTextColor
                    : kRentalZChipUnselectedTextColor,
              ),
              selected: _propertyType == PropertyType.apartment,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _propertyType = PropertyType.apartment;
                });
              },
            ),
            ChoiceChip(
              label: Text(
                'house',
                style: _propertyType == PropertyType.house
                    ? kRentalZChipOnSelectedTextColor
                    : kRentalZChipUnselectedTextColor,
              ),
              selected: _propertyType == PropertyType.house,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _propertyType = PropertyType.house;
                });
              },
            ),
            ChoiceChip(
              label: Text(
                'office',
                style: _propertyType == PropertyType.office
                    ? kRentalZChipOnSelectedTextColor
                    : kRentalZChipUnselectedTextColor,
              ),
              selected: _propertyType == PropertyType.office,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _propertyType = PropertyType.office;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildFurnitureTypeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Furniture Type',
          style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              label: Text(
                'unfurnished',
                style: _furnitureType == FurnitureType.unfurnished
                    ? kRentalZChipOnSelectedTextColor
                    : kRentalZChipUnselectedTextColor,
              ),
              selected: _furnitureType == FurnitureType.unfurnished,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _furnitureType = FurnitureType.unfurnished;
                });
              },
            ),
            ChoiceChip(
              label: Text(
                'half-furnished',
                style: _furnitureType == FurnitureType.halfFurnished
                    ? kRentalZChipOnSelectedTextColor
                    : kRentalZChipUnselectedTextColor,
              ),
              selected: _furnitureType == FurnitureType.halfFurnished,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _furnitureType = FurnitureType.halfFurnished;
                });
              },
            ),
            ChoiceChip(
              label: Text(
                'furnished',
                style: _furnitureType == FurnitureType.furnished
                    ? kRentalZChipOnSelectedTextColor
                    : kRentalZChipUnselectedTextColor,
              ),
              selected: _furnitureType == FurnitureType.furnished,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _furnitureType = FurnitureType.furnished;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          child: const Text('Select'),
          onPressed: () async {
            final currentDate = DateTime.now();
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: currentDate,
              firstDate: currentDate,
              lastDate: DateTime(currentDate.year + 5),
            );
            setState(() {
              if (selectedDate != null) {
                _dateAdded = selectedDate;
              }
            });
          },
        ),
        Column(
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            Text('${DateFormat('yyyy-MM-dd').format(_dateAdded)}'),
          ],
        ),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            ),
            Column(
              children: <Widget>[
                Text(
                  'Time',
                  style: GoogleFonts.lato(fontSize: 28.0),
                ),
                Text('${_timeOfDay.format(context)}'),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              // color: _currentColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
          ],
        ),
        TextButton(
          child: const Text('Select'),
          onPressed: () {
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       content: BlockPicker(
            //         pickerColor: Colors.white,
            //         onColorChanged: (Color color) {
            //           setState(() {
            //             _currentColor = color;
            //           });
            //         },
            //       ),
            //       actions: [
            //         TextButton(
            //           child: const Text('Save'),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         )
            //       ],
            //     );
            //   },
            // );
          },
        ),
      ],
    );
  }

  Widget buildNumberOfBedroomsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            SizedBox(
              width: 175,
              child: Text(
                'Number of Bedrooms:',
                style: GoogleFonts.lato(fontSize: 18.0),
              ),
            ),
            const SizedBox(width: 16.0),
            SizedBox(
              width: 5,
              child: Text(
                _currentNumberOfBedroomsValue.toInt().toString(),
                style: GoogleFonts.lato(fontSize: 16.0),
                textAlign: TextAlign.right,
              ),
            ),
            Slider(
                inactiveColor: Colors.blue.withOpacity(0.5),
                activeColor: Colors.blue,
                min: 0.0,
                max: 5.0,
                divisions: 5,
                label: _currentNumberOfBedroomsValue.toInt().toString(),
                value: _currentNumberOfBedroomsValue.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    _currentNumberOfBedroomsValue = value.toInt();
                  });
                })
          ],
        ),
      ],
    );
  }

  Widget buildPriceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                'Monthly Price:',
                style: GoogleFonts.lato(fontSize: 18.0),
              ),
            ),
            const SizedBox(width: 16.0),
            SizedBox(
              width: 60,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _priceController,
                // '\$' + _currentPriceValue.toInt().toString(),
                style: GoogleFonts.lato(fontSize: 16.0),
                decoration: InputDecoration.collapsed(
                  hintText: '\$' + _currentPriceValue.toInt().toString(),
                  hintStyle: TextStyle(color: Colors.black),
                ),

                textAlign: TextAlign.right,
                onChanged: (number) {
                  setState(() {
                    _currentPriceValue = int.parse(number);
                  });
                },
              ),
            ),
            Slider(
                inactiveColor: Colors.blue.withOpacity(0.5),
                activeColor: Colors.blue,
                min: 0.0,
                max: 5000.0,
                divisions: 500,
                label: _currentPriceValue.toInt().toString(),
                value: _currentPriceValue.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    _priceController.clear();
                    _currentPriceValue = value.toInt();
                  });
                })
          ],
        ),
      ],
    );
  }
}

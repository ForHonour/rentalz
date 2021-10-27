import 'property_item.dart';

class RentalPropertyRepository {
  static List<PropertyItem> loadProperties() {
    final allProperties = <PropertyItem>[
      PropertyItem(
        id: '1',
        name: 'Office 1',
        address: ['1 Hong Bang, P13, Q11, TP.HCM'],
        type: PropertyType.office,
        furniture: FurnitureType.furnished,
        numberOfBedrooms: 1,
        price: 1000,
        date: DateTime.utc(2020, 11, 12),
        nameOfReporter: 'Nguyen Van A',
        notes: '',
        isComplete: false,
      ),
      PropertyItem(
        id: '2',
        address: ['2 Hong Bang, P13, Q11, TP.HCM'],
        name: 'Office 2',
        type: PropertyType.office,
        furniture: FurnitureType.furnished,
        numberOfBedrooms: 2,
        price: 2000,
        date: DateTime.utc(2020, 11, 12),
        nameOfReporter: 'Nguyen Van B',
        notes: '',
        isComplete: false,
      ),
    ];

    return allProperties.toList();
  }
}

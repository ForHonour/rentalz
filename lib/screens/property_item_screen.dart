import 'dart:collection';

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
  // final _numberOfBedroomsController = TextEditingController();
  final _priceController = TextEditingController();

  final List<String> _listCity = [
    'Select City',
    'Thành phố Hà Nội',
    'Tỉnh Hà Giang',
    'Tỉnh Cao Bằng',
    'Tỉnh Bắc Kạn',
    'Tỉnh Tuyên Quang',
    'Tỉnh Lào Cai',
    'Tỉnh Điện Biên',
    'Tỉnh Lai Châu',
    'Tỉnh Sơn La',
    'Tỉnh Yên Bái',
    'Tỉnh Hoà Bình',
    'Tỉnh Thái Nguyên',
    'Tỉnh Lạng Sơn',
    'Tỉnh Quảng Ninh',
    'Tỉnh Bắc Giang',
    'Tỉnh Phú Thọ',
    'Tỉnh Vĩnh Phúc',
    'Tỉnh Bắc Ninh',
    'Tỉnh Hải Dương',
    'Thành phố Hải Phòng',
    'Tỉnh Hưng Yên',
    'Tỉnh Thái Bình',
    'Tỉnh Hà Nam',
    'Tỉnh Nam Định',
    'Tỉnh Ninh Bình',
    'Tỉnh Thanh Hoá',
    'Tỉnh Nghệ An',
    'Tỉnh Hà Tĩnh',
    'Tỉnh Quảng Bình',
    'Tỉnh Quảng Trị',
    'Tỉnh Thừa Thiên Huế',
    'Thành phố Đà Nẵng',
    'Tỉnh Quảng Nam',
    'Tỉnh Quảng Ngãi',
    'Tỉnh Bình Định',
    'Tỉnh Phú Yên',
    'Tỉnh Khánh Hoà',
    'Tỉnh Ninh Thuận',
    'Tỉnh Bình Thuận',
    'Tỉnh Kon Tum',
    'Tỉnh Gia Lai',
    'Tỉnh Đắk Lắk',
    'Tỉnh Đắk Nông',
    'Tỉnh Lâm Đồng',
    'Tỉnh Bình Phước',
    'Tỉnh Tây Ninh',
    'Tỉnh Bình Dương',
    'Tỉnh Đồng Nai',
    'Tỉnh Bà Rịa - Vũng Tàu',
    'Thành phố Hồ Chí Minh',
    'Tỉnh Long An',
    'Tỉnh Tiền Giang',
    'Tỉnh Bến Tre',
    'Tỉnh Trà Vinh',
    'Tỉnh Vĩnh Long',
    'Tỉnh Đồng Tháp',
    'Tỉnh An Giang',
    'Tỉnh Kiên Giang',
    'Thành phố Cần Thơ',
    'Tỉnh Hậu Giang',
    'Tỉnh Sóc Trăng',
    'Tỉnh Bạc Liêu',
    'Tỉnh Cà Mau',
  ];

  final List<String> _listQuanHuyen = [
    'Select District',
    'Quận 1',
    'Quận 12',
    'Quận Thủ Đức',
    'Quận 9',
    'Quận Gò Vấp',
    'Quận Bình Thạnh',
    'Quận Tân Bình',
    'Quận Tân Phú',
    'Quận Phú Nhuận',
    'Quận 2',
    'Quận 3',
    'Quận 10',
    'Quận 11',
    'Quận 4',
    'Quận 5',
    'Quận 6',
    'Quận 8',
    'Quận Bình Tân',
    'Quận 7',
    'Huyện Củ Chi',
    'Huyện Hóc Môn',
    'Huyện Bình Chánh',
    'Huyện Nhà Bè',
    'Huyện Cần Giờ',
  ];

  final Map<String, List<String>> _mapWard = {
    'Select District': ['Select Ward'],
    'Quận 1': [
      'Select Ward',
      'Phường Tân Định',
      'Phường Đa Kao',
      'Phường Bến Nghé',
      'Phường Bến Thành',
      'Phường Nguyễn Thái Bình',
      'Phường Phạm Ngũ Lão',
      'Phường Cầu Ông Lãnh',
      'Phường Cô Giang',
      'Phường Nguyễn Cư Trinh',
      'Phường Cầu Kho',
    ],
    'Quận 12': [
      'Select Ward',
      'Phường Thạnh Xuân',
      'Phường Thạnh Lộc',
      'Phường Hiệp Thành',
      'Phường Thới An',
      'Phường Tân Chánh Hiệp',
      'Phường An Phú Đông',
      'Phường Tân Thới Hiệp',
      'Phường Trung Mỹ Tây',
      'Phường Tân Hưng Thuận',
      'Phường Đông Hưng Thuận',
      'Phường Tân Thới Nhất',
    ],
    'Quận Thủ Đức': [
      'Select Ward',
      'Phường Linh Xuân',
      'Phường Bình Chiểu',
      'Phường Linh Trung',
      'Phường Tam Bình',
      'Phường Tam Phú',
      'Phường Hiệp Bình Phước',
      'Phường Hiệp Bình Chánh',
      'Phường Linh Chiểu',
      'Phường Linh Tây',
      'Phường Linh Đông',
      'Phường Bình Thọ',
      'Phường Trường Thọ',
    ],
    'Quận 9': [
      'Select Ward',
      'Phường Long Bình',
      'Phường Long Thạnh Mỹ',
      'Phường Tân Phú',
      'Phường Hiệp Phú',
      'Phường Tăng Nhơn Phú A',
      'Phường Tăng Nhơn Phú B',
      'Phường Phước Long B',
      'Phường Phước Long A',
      'Phường Trường Thạnh',
      'Phường Long Phước',
      'Phường Long Trường',
      'Phường Phước Bình',
      'Phường Phú Hữu',
    ],
    'Quận Gò Vấp': [
      'Select Ward',
      'Phường 15',
      'Phường 13',
      'Phường 17',
      'Phường 06',
      'Phường 16',
      'Phường 12',
      'Phường 14',
      'Phường 10',
      'Phường 05',
      'Phường 07',
      'Phường 04',
      'Phường 01',
      'Phường 09',
      'Phường 08',
      'Phường 11',
      'Phường 03',
    ],
    'Quận Bình Thạnh': [
      'Select Ward',
      'Phường 13',
      'Phường 11',
      'Phường 27',
      'Phường 26',
      'Phường 12',
      'Phường 25',
      'Phường 05',
      'Phường 07',
      'Phường 24',
      'Phường 06',
      'Phường 14',
      'Phường 15',
      'Phường 02',
      'Phường 01',
      'Phường 03',
      'Phường 17',
      'Phường 21',
      'Phường 22',
      'Phường 19',
      'Phường 28',
    ],
    'Quận Tân Bình': [
      'Select Ward',
      'Phường 02',
      'Phường 04',
      'Phường 12',
      'Phường 13',
      'Phường 01',
      'Phường 03',
      'Phường 11',
      'Phường 07',
      'Phường 05',
      'Phường 10',
      'Phường 06',
      'Phường 08',
      'Phường 09',
      'Phường 14',
      'Phường 15',
    ],
    'Quận Tân Phú': [
      'Select Ward',
      'Phường Tân Sơn Nhì',
      'Phường Tây Thạnh',
      'Phường Sơn Kỳ',
      'Phường Tân Qúy',
      'Phường Tân Thành',
      'Phường Phú Thọ Hoà',
      'Phường Phú Thạnh',
      'Phường Phú Trung',
      'Phường Hoà Thạnh',
      'Phường Hiệp Tân',
      'Phường Tân Thới Hoà',
    ],
    'Quận Phú Nhuận': [
      'Select Ward',
      'Phường 04',
      'Phường 05',
      'Phường 09',
      'Phường 07',
      'Phường 03',
      'Phường 01',
      'Phường 02',
      'Phường 08',
      'Phường 15',
      'Phường 10',
      'Phường 11',
      'Phường 17',
      'Phường 14',
      'Phường 12',
      'Phường 13',
    ],
    'Quận 2': [
      'Select Ward',
      'Phường Thảo Điền',
      'Phường An Phú',
      'Phường Bình An',
      'Phường Bình Trưng Đông',
      'Phường Bình Trưng Tây',
      'Phường Bình Khánh',
      'Phường An Khánh',
      'Phường Cát Lái',
      'Phường Thạnh Mỹ Lợi',
      'Phường An Lợi Đông',
      'Phường Thủ Thiêm',
    ],
    'Quận 3': [
      'Select Ward',
      'Phường 08',
      'Phường 07',
      'Phường 14',
      'Phường 12',
      'Phường 11',
      'Phường 13',
      'Phường 06',
      'Phường 09',
      'Phường 10',
      'Phường 04',
      'Phường 05',
      'Phường 03',
      'Phường 02',
      'Phường 01',
    ],
    'Quận 10': [
      'Select Ward',
      'Phường 15',
      'Phường 13',
      'Phường 14',
      'Phường 12',
      'Phường 11',
      'Phường 10',
      'Phường 09',
      'Phường 01',
      'Phường 08',
      'Phường 02',
      'Phường 04',
      'Phường 07',
      'Phường 05',
      'Phường 06',
      'Phường 03',
    ],
    'Quận 11': [
      'Select Ward',
      'Phường 15',
      'Phường 05',
      'Phường 14',
      'Phường 11',
      'Phường 03',
      'Phường 10',
      'Phường 13',
      'Phường 08',
      'Phường 09',
      'Phường 12',
      'Phường 07',
      'Phường 06',
      'Phường 04',
      'Phường 01',
      'Phường 02',
      'Phường 16',
    ],
    'Quận 4': [
      'Select Ward',
      'Phường 12',
      'Phường 13',
      'Phường 09',
      'Phường 06',
      'Phường 08',
      'Phường 10',
      'Phường 05',
      'Phường 18',
      'Phường 14',
      'Phường 04',
      'Phường 03',
      'Phường 16',
      'Phường 02',
      'Phường 15',
      'Phường 01',
    ],
    'Quận 5': [
      'Select Ward',
      'Phường 04',
      'Phường 09',
      'Phường 03',
      'Phường 12',
      'Phường 02',
      'Phường 08',
      'Phường 15',
      'Phường 07',
      'Phường 01',
      'Phường 11',
      'Phường 14',
      'Phường 05',
      'Phường 06',
      'Phường 10',
      'Phường 13',
    ],
    'Quận 6': [
      'Select Ward',
      'Phường 14',
      'Phường 13',
      'Phường 09',
      'Phường 06',
      'Phường 12',
      'Phường 05',
      'Phường 11',
      'Phường 02',
      'Phường 01',
      'Phường 04',
      'Phường 08',
      'Phường 03',
      'Phường 07',
      'Phường 10',
    ],
    'Quận 8': [
      'Select Ward',
      'Phường 08',
      'Phường 02',
      'Phường 01',
      'Phường 03',
      'Phường 11',
      'Phường 09',
      'Phường 10',
      'Phường 04',
      'Phường 13',
      'Phường 12',
      'Phường 05',
      'Phường 14',
      'Phường 06',
      'Phường 15',
      'Phường 16',
      'Phường 07',
    ],
    'Quận Bình Tân': [
      'Select Ward',
      'Phường Bình Hưng Hòa',
      'Phường Bình Hưng Hoà A',
      'Phường Bình Hưng Hoà B',
      'Phường Bình Trị Đông',
      'Phường Bình Trị Đông A',
      'Phường Bình Trị Đông B',
      'Phường Tân Tạo',
      'Phường Tân Tạo A',
      'Phường An Lạc',
      'Phường An Lạc A',
    ],
    'Quận 7': [
      'Select Ward',
      'Phường Tân Thuận Đông',
      'Phường Tân Thuận Tây',
      'Phường Tân Kiểng',
      'Phường Tân Hưng',
      'Phường Bình Thuận',
      'Phường Tân Quy',
      'Phường Phú Thuận',
      'Phường Tân Phú',
      'Phường Tân Phong',
      'Phường Phú Mỹ',
    ],
    'Huyện Củ Chi': [
      'Select Ward',
      'Thị trấn Củ Chi',
      'Xã Phú Mỹ Hưng',
      'Xã An Phú',
      'Xã Trung Lập Thượng',
      'Xã An Nhơn Tây',
      'Xã Nhuận Đức',
      'Xã Phạm Văn Cội',
      'Xã Phú Hòa Đông',
      'Xã Trung Lập Hạ',
      'Xã Trung An',
      'Xã Phước Thạnh',
      'Xã Phước Hiệp',
      'Xã Tân An Hội',
      'Xã Phước Vĩnh An',
      'Xã Thái Mỹ',
      'Xã Tân Thạnh Tây',
      'Xã Hòa Phú',
      'Xã Tân Thạnh Đông',
      'Xã Bình Mỹ',
      'Xã Tân Phú Trung',
      'Xã Tân Thông Hội',
    ],
    'Huyện Hóc Môn': [
      'Select Ward',
      'Thị trấn Hóc Môn',
      'Xã Tân Hiệp',
      'Xã Nhị Bình',
      'Xã Đông Thạnh',
      'Xã Tân Thới Nhì',
      'Xã Thới Tam Thôn',
      'Xã Xuân Thới Sơn',
      'Xã Tân Xuân',
      'Xã Xuân Thới Đông',
      'Xã Trung Chánh',
      'Xã Xuân Thới Thượng',
      'Xã Bà Điểm',
    ],
    'Huyện Bình Chánh': [
      'Select Ward',
      'Thị trấn Tân Túc',
      'Xã Phạm Văn Hai',
      'Xã Vĩnh Lộc A',
      'Xã Vĩnh Lộc B',
      'Xã Bình Lợi',
      'Xã Lê Minh Xuân',
      'Xã Tân Nhựt',
      'Xã Tân Kiên',
      'Xã Bình Hưng',
      'Xã Phong Phú',
      'Xã An Phú Tây',
      'Xã Hưng Long',
      'Xã Đa Phước',
      'Xã Tân Quý Tây',
      'Xã Bình Chánh',
      'Xã Quy Đức',
    ],
    'Huyện Nhà Bè': [
      'Select Ward',
      'Thị trấn Nhà Bè',
      'Xã Phước Kiển',
      'Xã Phước Lộc',
      'Xã Nhơn Đức',
      'Xã Phú Xuân',
      'Xã Long Thới',
      'Xã Hiệp Phước',
    ],
    'Huyện Cần Giờ': [
      'Select Ward',
      'Thị trấn Cần Thạnh',
      'Xã Bình Khánh',
      'Xã Tam Thôn Hiệp',
      'Xã An Thới Đông',
      'Xã Thạnh An',
      'Xã Long Hòa',
      'Xã Lý Nhơn',
    ],
  };

  bool _isNameComposing = false;
  bool _isAddressComposing = false;

  // final FocusNode _nameFocusNode = FocusNode();
  // final FocusNode _addressFocusNode = FocusNode();

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
      _currentNumberOfBedroomsValue = originalItem.bedrooms;
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
      _addressController.dispose();
      super.dispose();
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
      // _nameFocusNode.requestFocus();
    });
    _addressController.addListener(() {
      setState(() {
        _addressNumber = _addressController.text;
      });
      // _addressFocusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
            ),
            color: Colors.blue,
            disabledColor: Colors.grey,
            onPressed: _isNameComposing &&
                    _isAddressComposing &&
                    _dropdownCityValue != 'Select City' &&
                    _currentPriceValue != 0
                ? () {
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
                      bedrooms: _currentNumberOfBedroomsValue,
                      price: _currentPriceValue,
                      date: DateTime(
                        _dateAdded.year,
                        _dateAdded.month,
                        _dateAdded.day,
                        _timeOfDay.hour,
                        _timeOfDay.minute,
                      ),

                      reporter: 'Khang',
                      rented: false,
                    );
                    if (widget.isUpdating) {
                      widget.onUpdate(propertyItem);
                    } else {
                      widget.onCreate(propertyItem);
                    }
                  }
                : null,
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
            const SizedBox(height: 4.0),
            buildAddressField(),
            const SizedBox(height: 4.0),
            buildPropertyTypeField(),
            const SizedBox(height: 4.0),
            buildFurnitureTypeField(),
            const SizedBox(height: 4.0),
            buildNumberOfBedroomsField(),
            buildPriceField(),
            const SizedBox(height: 4.0),
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
                bedrooms: _currentNumberOfBedroomsValue,
                date: DateTime(
                  _dateAdded.year,
                  _dateAdded.month,
                  _dateAdded.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),

                reporter: '',
                rented: false,
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
        Row(
          children: [
            Text(
              'Property Name',
              style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              '*',
              style: TextStyle(fontSize: 24.0, color: Colors.red),
            ),
          ],
        ),
        TextField(
          controller: _nameController,
          // cursorColor: _currentColor,
          onChanged: (text) {
            setState(() {
              _isNameComposing = text.isNotEmpty;
            });
          },
          decoration: const InputDecoration(
            hintText: 'E.g. Đại Nam, Thuỷ Tề ...',
            enabledBorder: UnderlineInputBorder(
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
        Row(
          children: [
            Text(
              'Property Address',
              style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Text(
              '*',
              style: TextStyle(fontSize: 24.0, color: Colors.red),
            ),
          ],
        ),
        TextField(
          controller: _addressController,
          // cursorColor: _currentColor,
          onChanged: (text) {
            setState(() {
              _isAddressComposing = text.isNotEmpty;
            });
          },
          decoration: const InputDecoration(
            hintText: 'E.g. 543 Hồng Bàng St.',
            enabledBorder: UnderlineInputBorder(
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
              child: Row(
                children: [
                  Text(
                    'City: ',
                    style: GoogleFonts.lato(fontSize: 18.0),
                  ),
                  Text(
                    '*',
                    style: TextStyle(fontSize: 24.0, color: Colors.red),
                  ),
                ],
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
                    _dropdownDistrictValue = 'Select District';
                    _dropdownWardValue = 'Select Ward';
                  });
                },
                items: _listCity.map<DropdownMenuItem<String>>((String value) {
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
                    _dropdownWardValue = 'Select Ward';
                  });
                },
                items: _listQuanHuyen.map<DropdownMenuItem<String>>((String value) {
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
                items:
                    // _dropdownDistrictValue == 'Select District' ? <String>['Select Ward'].toList() :
                    //  <String>['Select Ward', 'One', 'Two', 'Free', 'Four']
                    _mapWard[_dropdownDistrictValue]!.map<DropdownMenuItem<String>>((String value) {
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
              width: 190,
              child: Text(
                'Number of Bedrooms:',
                style: GoogleFonts.lato(fontSize: 18.0),
              ),
            ),
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
              width: 135,
              child: Row(
                children: [
                  Text(
                    'Monthly Price: ',
                    style: GoogleFonts.lato(fontSize: 18.0),
                  ),
                  Text(
                    '*',
                    style: TextStyle(fontSize: 24.0, color: Colors.red),
                  ),
                ],
              ),
            ),
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

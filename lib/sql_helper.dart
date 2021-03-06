import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'models/models.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE properties(
        id TEXT PRIMARY KEY NOT NULL,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
				city TEXT NOT NULL,
				district TEXT NOT NULL,
				ward TEXT NOT NULL,
        type TEXT NOT NULL,
        furniture TEXT,
				bedrooms INTEGER,
				price INTEGER NOT NULL,
        date TEXT NOT NULL,
        reporter TEXT NOT NULL,
				notes TEXT NOT NULL,
				rented INTEGER NOT NULL
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'rentalz.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(PropertyItem item) async {
    final db = await SQLHelper.db();

    String propertyTypeString;
    String furnitureTypeString;

    if (item.type == PropertyType.apartment) {
      propertyTypeString = 'apartment';
    } else if (item.type == PropertyType.house) {
      propertyTypeString = 'house';
    } else {
      propertyTypeString = 'office';
    }

    if (item.furniture == FurnitureType.unfurnished) {
      furnitureTypeString = 'unfurnished';
    } else if (item.furniture == FurnitureType.halfFurnished) {
      furnitureTypeString = 'halfFurnished';
    } else {
      furnitureTypeString = 'furnished';
    }

    final data = {
      'id': item.id,
      'name': item.name,
      'address': item.address,
      'city': item.city,
      'district': item.district,
      'ward': item.ward,
      'type': propertyTypeString,
      'furniture': furnitureTypeString,
      'bedrooms': item.bedrooms,
      'price': item.price,
      'date': DateFormat('yyyy-MM-dd').format(item.date),
      'reporter': item.reporter,
      'rented': item.rented == false ? 0 : 1,
      'notes': item.notes,
    };
    final id =
        await db.insert('properties', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('properties', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(String id) async {
    final db = await SQLHelper.db();
    return db.query('properties', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(PropertyItem item) async {
    final db = await SQLHelper.db();

    String propertyTypeString;
    String furnitureTypeString;

    if (item.type == PropertyType.apartment) {
      propertyTypeString = 'apartment';
    } else if (item.type == PropertyType.house) {
      propertyTypeString = 'house';
    } else {
      propertyTypeString = 'office';
    }

    if (item.furniture == FurnitureType.unfurnished) {
      furnitureTypeString = 'unfurnished';
    } else if (item.furniture == FurnitureType.halfFurnished) {
      furnitureTypeString = 'halfFurnished';
    } else {
      furnitureTypeString = 'furnished';
    }

    final data = {
      'id': item.id,
      'name': item.name,
      'address': item.address,
      'city': item.city,
      'district': item.district,
      'ward': item.ward,
      'type': propertyTypeString,
      'furniture': furnitureTypeString,
      'bedrooms': item.bedrooms,
      'price': item.price,
      'date': DateFormat('yyyy-MM-dd').format(item.date),
      'reporter': item.reporter,
      'rented': item.rented == false ? 0 : 1,
      'notes': item.notes,
    };

    final result = await db.update('properties', data, where: "id = ?", whereArgs: [item.id]);
    return result;
  }

  static Future<void> deleteItem(String id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("properties", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> searchItem(String query) async {
    final db = await SQLHelper.db();
    return db.query(
      "properties",
      where: "name LIKE ? OR address LIKE ? OR city LIKE ? OR district LIKE ? OR ward LIKE ?",
      whereArgs: [
        query,
        query,
        query,
        query,
        query,
      ],
      limit: 3,
    );
  }
}

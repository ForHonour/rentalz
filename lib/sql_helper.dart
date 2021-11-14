import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'models/models.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE properties(
        id TEXT PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        type TEXT NOT NULL,
        furniture TEXT,
				bedrooms INTEGER,
				price INTEGER NOT NULL,
        date TEXT NOT NULL,
        reporter TEXT NOT NULL,
				rented INTEGER NOT NULL
      )
      """);

    // await database.execute("""CREATE TABLE IF NOT EXISTS Notes(
    //     id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    // 		note TEXT NOT NULL,
    //   )
    //   """);
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

  static Future<int> createItem(
    String uuid,
    String propertyName,
    List<String> propertyAddress,
    PropertyType propertyType,
    FurnitureType furnitureType,
    int bedrooms,
    int price,
    DateTime date,
    String reporter,
    bool rented,
    // List<String>? notes,
  ) async {
    final db = await SQLHelper.db();

    String propertyTypeString;
    String furnitureTypeString;

    if (propertyType == PropertyType.apartment) {
      propertyTypeString = 'apartment';
    } else if (propertyType == PropertyType.house) {
      propertyTypeString = 'house';
    } else {
      propertyTypeString = 'office';
    }

    if (furnitureType == FurnitureType.unfurnished) {
      furnitureTypeString = 'unfurnished';
    } else if (furnitureType == FurnitureType.halfFurnished) {
      furnitureTypeString = 'halfFurnished';
    } else {
      furnitureTypeString = 'furnished';
    }

    final data = {
      'id': uuid,
      'name': propertyName,
      'address': propertyAddress.join(', '),
      'type': propertyTypeString,
      'furniture': furnitureTypeString,
      'bedrooms': bedrooms,
      'price': price,
      'date': DateFormat('MMMM dd h:mm a').format(date),
      'reporter': reporter,
      'rented': rented == false ? 0 : 1,
      // 'notes': notes,
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

  static Future<int> updateItem(
    String id,
    String propertyName,
    List<String> propertyAddress,
    PropertyType propertyType,
    FurnitureType furnitureType,
    int bedrooms,
    int price,
    DateTime date,
    String reporter,
    bool rented,
    // List<String>? notes,
  ) async {
    final db = await SQLHelper.db();

    String propertyTypeString;
    String furnitureTypeString;

    if (propertyType == PropertyType.apartment) {
      propertyTypeString = 'apartment';
    } else if (propertyType == PropertyType.house) {
      propertyTypeString = 'house';
    } else {
      propertyTypeString = 'office';
    }

    if (furnitureType == FurnitureType.unfurnished) {
      furnitureTypeString = 'unfurnished';
    } else if (furnitureType == FurnitureType.halfFurnished) {
      furnitureTypeString = 'halfFurnished';
    } else {
      furnitureTypeString = 'furnished';
    }

    final data = {
      'id': id,
      'name': propertyName,
      'address': propertyAddress.join(', '),
      'type': propertyTypeString,
      'furniture': furnitureTypeString,
      'bedrooms': bedrooms,
      'price': price,
      'date': date.toString(),
      'reporter': reporter,
      'rented': rented == false ? 0 : 1,
      // 'notes': notes,
    };

    final result = await db.update('properties', data, where: "id = ?", whereArgs: [id]);
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
}

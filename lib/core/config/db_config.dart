// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  //User Table:
  static const String TABLE_COURSE = 'course';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_TITLE = 'title';
  static const String COLUMN_DESC = 'desc';
  static const String COLUMN_THUMBNAIL = 'thumbnail_path';
  static const String COLUMN_PRICE = 'price';
  static const String COLUMN_DATE = 'date';

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'assam_edu_db.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_COURSE (
        $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $COLUMN_TITLE TEXT,
        $COLUMN_DESC TEXT,
        $COLUMN_PRICE TEXT,
        $COLUMN_THUMBNAIL BLOB,
        $COLUMN_DATE TEXT DEFAULT (datetime('now'))
      )
    ''');
  }

  // Function to convert File to Uint8List (for BLOB)
  Future<Uint8List> _readFileBytes(File file) async {
    return await file.readAsBytes();
  }

  Future<bool> insertCourse({
    required String title,
    required String desc,
    required String price,
    required File imageFile,
  }) async {
    final Uint8List imageBytes =
        await _readFileBytes(imageFile); // Read file as bytes
    final db = await database;
    final id = await db.insert(TABLE_COURSE, {
      COLUMN_TITLE: title,
      COLUMN_DESC: desc,
      COLUMN_PRICE: price,
      COLUMN_THUMBNAIL: imageBytes
    });

    return id > 0;
  }

  Future<List<Map<String, dynamic>>> getCourses() async {
    final db = await database;
    return await db.query(TABLE_COURSE);
  }

  Future<List<Map<String, dynamic>>> getCourse({required int id}) async {
    final db = await database;
    return await db.query(
      TABLE_COURSE,
      where: '$COLUMN_ID = ?',
      whereArgs: [id],
    );
  }

  Future<bool> deleteCourse({required int id}) async {
    final db = await database;
    final res = await db.delete(
      TABLE_COURSE,
      where: '$COLUMN_ID = ?',
      whereArgs: [id],
    );
    return res > 0;
  }
}

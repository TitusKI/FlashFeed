import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_models.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;
  NewsDbProvider() {
    init();
  }
  // To Fetch Top Ids from database when no access to api
  @override
  Future<List<int>>? fetchTopIds() {
    return null;
  }

  init() async {
    Directory documentD = await getApplicationDocumentsDirectory();
    final path = join(documentD.path, 'items.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newdb, int version) {
      newdb.execute('''
      CREATE TABLE Items(
      id INTEGER PRIMARY KEY,
      type TEXT,
      time INT,
      text TEXT,
      parent INT,
      url TEXT,
      score INT, 
      title TEXT,
      descendants TEXT,
      deleted INTEGER,
      dead INTEGER,
      kids BLOB
     
      )
      ''');
    });
  }

  @override
  Future<ItemModel?> fetchItems(int id) async {
    final map = await db
        .query('Items', columns: null, where: 'id = ?', whereArgs: [id]);
    if (map.isNotEmpty) {
      return ItemModel.fromDb(map.first);
    }
    return null;
  }

  @override
  Future<int> addItems(ItemModel item) {
    return db.insert('Items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> clear() {
    return db.delete("Items");
  }
}

final dpapi = NewsDbProvider();

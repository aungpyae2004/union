import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:union/data/model/cart.dart';

class DbHelper {
  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "db/cart.db");

    final exist = await databaseExists(path);
    if (exist) {
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join("assets", "db/cart.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    var cartDataTable = await openDatabase(path);
    return cartDataTable;
  }

  Future<List<Cart>> getCart() async {
    Database db = await initDb();
    List<Map<String, dynamic>> words = await db.query("cart",
        columns: [
          "id",
          "name",
          "price",
          "image_url",
          "product_id",
          "size",
          "chosen"
        ],
        where: "chosen = ?",
        whereArgs: ["1"]);
    return words.map((e) => Cart.fromMap(e)).toList();
  }

  /// In this scenario, I use rawUpdate function instead of using insert one.
  Future addToCart(Cart cart) async {
    Database db = await initDb();
    db.rawUpdate('''
    UPDATE cart 
    SET price = ?, image_url = ?, size = ?, chosen = ? 
    WHERE product_id = ?
    ''', [cart.price, cart.imageUrl, cart.size, cart.chosen, cart.productId]);
  }

  Future removeFromCart(Cart cart) async {
    Database db = await initDb();
    db.rawUpdate('''
    UPDATE cart 
    SET chosen = ? 
    WHERE product_id = ?
    ''', [cart.chosen, cart.productId]);
  }
}

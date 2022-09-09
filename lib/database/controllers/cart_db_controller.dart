
import 'package:smart_store/database/db_oberations.dart';
import 'package:smart_store/models/cart.dart';
import 'package:sqflite/sqflite.dart';

import '../../prefs/shared_pref_controller.dart';

class CartDbController extends DbOperations<Cart> {

  @override
  Future<int> create(Cart model) async {
    // User add new Item for the first time to the cart
    return await database.insert(Cart.tableName, model.toJson());
  }

  @override
  Future<bool> delete(String id) async {
    int countOfDeletedRows = await database.delete(
      Cart.tableName,
      where: 'product_id = ?',
      whereArgs: [id],
    );
    return countOfDeletedRows == 1;
  }

  @override
  Future<List<Cart>> read() async {
    //SELECT cart.id, cart.product_id, cart.count, cart.total, cart.price, product.name as product_name
    // FROM cart JOIN products ON cart.product_id = products.id
    //WHERE cart.user_id = ?
    // List<Map<String, dynamic>> rowsMap = await database.query(
    //   Cart.tableName,
    //   where: 'user_id = ?',
    //   whereArgs: [userId],
    // );
    List<Map<String, dynamic>> rowsMap = await database.query(
      Cart.tableName,
    );
    print(rowsMap);
    return rowsMap.map((rowMap) => Cart.fromJson(rowMap)).toList();
  }

  @override
  Future<Cart?> show(int id) {
    // TODO: implement show
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Cart model) async {
    int countOfUpdatedRows = await database.update(
      Cart.tableName,
      model.toJson(),
      where: 'product_id = ?',
      whereArgs: [model.productId],
    );
    return countOfUpdatedRows == 1;
  }

  Future<double> getTotal() async {
    var result = await database.rawQuery("SELECT SUM(price) FROM ${Cart.tableName}");
    var value = result[0]["SUM(price)"];
    return double.parse(value.toString());
  }

  Future<int> getQuantity() async {
    int? count = Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM ${Cart.tableName}'));
    return count??0;
  }

  @override
  Future<bool> clear() async {
    int countOfDeletedRows = await database.delete(
      Cart.tableName,
    );
    return countOfDeletedRows > 0;
  }
}
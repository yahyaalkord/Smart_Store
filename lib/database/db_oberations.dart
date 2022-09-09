

import 'package:sqflite/sqflite.dart';

import 'db_controller.dart';

abstract class DbOperations<Model> {
  final Database database = DbController().database;

  // final int userId = SharedPrefController().getValueFor<int>(PrefKeys.id.name) ?? 0;

  Future<int> create(Model model);

  Future<List<Model>> read();

  Future<Model?> show(int id);

  Future<bool> update(Model model);

  Future<bool> delete(String id);

  Future<void> clear() async {

  }
}
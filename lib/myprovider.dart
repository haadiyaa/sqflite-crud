import 'package:flutter/material.dart';
import 'package:sqflite_sample/db.dart';
import 'package:sqflite_sample/model.dart';

class MyProvider extends ChangeNotifier {
  List<ModelClass> list = [];
  Future<void> getAllData() async {
    list = await SqflitDB.getData(list);
    notifyListeners();
  }

  Future<void> add(ModelClass model) async {
    await SqflitDB.insertData(model);
    await getAllData();
  }
  Future<void> update(ModelClass model) async {
    await SqflitDB.update(model);
    await getAllData();
  }

  Future<void> delete(int? id) async {
    await SqflitDB.delete(id);
    await getAllData();
  }
}

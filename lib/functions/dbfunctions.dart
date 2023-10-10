// ignore_for_file: unused_import, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lastapp/model/dbmodel.dart';

ValueNotifier<List<studentModel>>studenlistnotfier =ValueNotifier([]);



Future <void> addstud(studentModel value)async
{
  final studentDb = await Hive.openBox<studentModel>("student_db");
    await studentDb.add(value);
    getAllStud();
}

Future<void> getAllStud()async{
   final studentDb= await Hive.openBox<studentModel>("student_db");
  studenlistnotfier.value.clear();
  studenlistnotfier.value.addAll(studentDb.values);
  studenlistnotfier.notifyListeners(); 
}

Future<void> deletestud(int index)async{
  final studentDb= await Hive.openBox<studentModel>("student_db"); 
   await studentDb.deleteAt(index);
  getAllStud();
}
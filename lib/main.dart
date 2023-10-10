
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lastapp/model/dbmodel.dart';
import 'package:lastapp/screens/liststudent.dart';

Future<void> main() async{
 await Hive.initFlutter();
 if(!Hive.isAdapterRegistered(studentModelAdapter().typeId))
 {
  Hive.registerAdapter(studentModelAdapter());
 }


  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 22, 119, 9)),),
      debugShowCheckedModeBanner: false,
      home:ListStudent(),
    );
  }
}
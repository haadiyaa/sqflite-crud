import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_sample/db.dart';
import 'package:sqflite_sample/homepage.dart';
import 'package:sqflite_sample/myprovider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqflitDB.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

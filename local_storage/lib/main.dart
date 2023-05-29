import 'package:flutter/material.dart';
import 'key_value/key_value_demo.dart';
import 'sqlite/memo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.orange[50],
        brightness: Brightness.dark,
      ),
      home: const MemoListScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insightho/api/gsheet_api.dart';
import 'package:insightho/components/nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insight tho',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        canvasColor: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const Nav(),
    );
  }
}
import 'package:dungeonsanddragons_helper/ui/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D&D Helper',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 16.0),
        ),
        dataTableTheme: DataTableThemeData(dataTextStyle: Theme.of(context).textTheme.bodyText2)
      ),
      home: HomePage(),
    );
  }
}



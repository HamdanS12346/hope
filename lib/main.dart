import 'package:flutter/material.dart';
import 'package:hope/details.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
                color:Color(0xFF907F9F)
            )
        ),
        fontFamily: 'Urbanist',
      ),
      home: DetailsPage(),
      routes: {

      },
    );
  }
}
import 'package:bytebank_ii/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankII());
}

class ByteBankII extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}

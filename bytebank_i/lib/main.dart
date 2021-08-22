import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBank());
}

class ByteBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter I',
      home: ListaTransferencias(),
      theme: ThemeData(
        primaryColor: Colors.green[900],
        //AccentColor - Secondary
        accentColor: Colors.blueGrey,
        //No botão, tem que por atributo destinado a ele
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;
  //Com o Null Safety, pra dizer que uma variável pode ser null é só por ? -> IconData?

  //Pode colocar param opcional nomeado, envolvendo com {}, mas pra isso os attr não podem ser privados
  const Editor({
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        //Pra editar texto no Flutter, sempre vai usar style -> textStyle; Costuma seguir base de 8 em 8
        //Widget responsável pras bordas: padding etc
        style: TextStyle(fontSize: 16.0),
        controller: controlador,
        decoration: InputDecoration(
          //if ternario pra tirar o espaço do widget q n possui icone
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando Transferência';
const _dicaCampoValor = '0.00';
const _dicaCampoNumeroConta = '0000';
const _rotuloCampoNumeroConta = 'Número da Conta';
const _rotuloCampoValor = 'Valor';
const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  //Textfield só funcionava total corretamente no modo paisagem ao usar o Stateful
  //Agora, parece que isso foi corrigido, então pode deixar no Stateless mesmo
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  //Nesse caso, tinha que tá aqui, não usando widget.
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      //SingleChildScrollView dá comportamento de scroll envolvendo outro widget
      //Colocado por causa do modo paisagem
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
            ),
            Editor(
              controlador: _controladorCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
              rotulo: _rotuloCampoValor,
            ),
            ElevatedButton(
              onPressed: () => _criaTransferencia(context),
              child: Text(_textoBotaoConfirmar),
            )
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      //se tentar debugPrint('$transferenciaCriada'), vai printar Instance of Transferencia pois é um objeto
      //pra imprimir, tem que colocar toString()
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('$transferenciaCriada'),
      //   ),
      // );
      Navigator.pop(context, transferenciaCriada);
      //Tira a tela da pilha de telas; como 2ª param pode mandar o valor
    }
  }
}

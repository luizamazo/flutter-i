import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transferências - BYTEBANK';

class ListaTransferencias extends StatefulWidget {
  //Quando o build vai pro state, fica sem referencia pra criação da lista; primeira alt seria copiar o código
  //pra da declaração pra dentro do escopo do state, mas há algumas regras/costumes pro stateful widget:
  //Se vai lidar com objetos que serão modificados, determina que ele vai ficar dentro do state
  //Se for referencias q serão constantes, deixa dentro do widget de Stateful e acessa os attrs por meio de um objeto
  //chamado de widget.
  final List<Transferencia> _transferencias = [];

  //No StatefulWidget n tem o override do build  q eh responsavel de montar a árvore de widgets q qer representar pro widget q se cria, o personalizado
  //Pra fazer isso, se tem acesso ao objeto q representa o estado do stateful widget.

  @override
  State<StatefulWidget> createState() {
    //Tem q devolver a referencia criada
    return ListaTransferenciasState();
  }
}

//Precisa criar o state pra conseguir devolver a instancia dele, pode criar como classe mesmo
class ListaTransferenciasState extends State<ListaTransferencias> {
  //No StatefulWidget, ele sempre chama esse build de novo, no Stateless n
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      //Column não permite comportamento de scroll ou att de lista, então ListView, mas isso pra estático, pra dinamico, usa ListView.builder
      //Pra conseguir qtd de itens q espera dinamicamente, precisa da lista da collections, entao precisa criar uma.
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          //A transf vem a partir do indice
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        //Navegação de tela com Navigator; Pode criar uma route, 2ª param, mas facilita com o do MD.
        //builder pra implementar função que vai receber qual tela vai entrar
        onPressed: () {
          //Future vai ser como um callback, que permite que tenha acesso a uma possível resposta
          //durante a navegação. Pra acessar o valor, vai ter q haver uma outra func de callback que só vai
          //receber o valor no momento que tiver retorno.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
            //Quando se usa o future, assim future.then(onValue), ele entende que é um valor genérico qualquer,
            //mas é uma transferência, então lá em cima na declaração, Future<Transferencia>
          ).then(
            (transferenciaRecebida) => _atualiza(transferenciaRecebida),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _atualiza(Transferencia transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      //Não é assim que atualiza -> widget._transferencias.add(transferenciaRecebida);
      //Pois assim, dá problema de async, não chama o build novamente
      //Tem que usar setState, depois que add é executado, ele chamaria o build
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

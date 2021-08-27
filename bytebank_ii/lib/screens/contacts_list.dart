import 'package:bytebank_ii/database/dao/contact_dao.dart';
import 'package:bytebank_ii/models/contact.dart';
import 'package:bytebank_ii/screens/contacts_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  //No BYTEBANK I, a lista era um stateful widget pra poder ser atualizada
  //Aqui, será usado o FutureBuilder que irá realizar a operação assíncrona que chamará o DB
  //++ mas parece q vai te q ser stateful mesmo
  @override
  State<StatefulWidget> createState() {
    return _ContactsListState();
  }
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        //pode ter problema com lista nula antes da chamada ser completada
        //pode resolver colocando um if(snapshot != null) etc;
        //future delayed foi só pra testar uma possível demora no carregamento
        //mas pode tb colocar um data inicial, do tipo lista, mas que como o future
        //é dinâmico, tem que colocar um generic nele pra dizer que é uma lista vazia
        //mas do tipo contacts
        //pode ter a demorazinha na hora de carregar, aí põe uma loading screen
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          //snapshot é basicamente uma response!
          switch (snapshot.connectionState) {
            // case ConnectionState.none:
            //   pra quando quer inicializar o future, com um botão etc
            //   break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      'Loading...',
                      style: TextStyle(fontSize: 24.0),
                    )
                  ],
                ),
              );
              break;
            // case ConnectionState.active:
            // pra casos de downloads/stream, onde ele retorna porcentagens etc
            //   break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactsItem(contact);
                },
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ContactsForm()))
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactsItem extends StatelessWidget {
  final Contact contact;
  const _ContactsItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

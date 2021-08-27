import 'package:bytebank_ii/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabaseTeste() {
  //primeiro precisa pegar o caminho do banco de dados
  return getDatabasesPath().then(
    (dbPath) {
      //cria o arquivo que representa o db
      //usa o join; ela pega diversas strings que pode enviar via arg e vai juntá-las
      //responsabilidade é: ele vai fazer a junção que é compatível a partir do SO que está operando
      //segundo param é o nome do arquivo q vai representar o db, q deve ter extensao .db
      final String path = join(dbPath, 'bytebank.db');
      //apos pegar o caminho, chama função que vai abrir o db
      //no on create, passa a função que passa o database o int, que é a versão
      return openDatabase(
        path,
        onCreate: (db, version) {
          db.execute('CREATE TABLE contacts('
              'id INTEGER PRIMARY KEY, '
              'name TEXT, '
              'acco unt_number INTEGER)');
        },
        version: 1,
        //Se quiser adicionar um novo campo no banco e tals pode incrementar a versão; downgrade volta
        //pra limpar o db primeiro precisa att a versão e depois voltar pra 1 e quando voltar pra 1, executa o trecho abaixo
        //onDowngrade: onDatabaseDowngradeDelete,
      );
    },
  );
}

Future<int> saveTeste(Contact contact) {
  //precisa criar um mapa com chave de string e um valor dynamic pq o a api do sqflite não sabe salvar
  //todos os objs do mundo, mas consegue salvar uma estrutura que consegue converter qualquer tipo de objeto
  //pra essa estrutura; a chave identifica a coluna e o dynamic recebe qualquer tipo q há no dart
  return createDatabaseTeste().then((db) {
    //dentro de [] eh referente ao campo da coluna da tabela
    final Map<String, dynamic> contactMap = Map();
    //id o sqlite já incrementa quando é do tipo int
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert('contacts', contactMap);
  });
}

Future<List<Contact>> findAllTeste() {
  return createDatabaseTeste().then((db) {
    //com query, pega todos os dados da tabela
    return db.query('contacts').then((maps) {
      //precisa varrer a lista, pegar cada um desses mapas, e converter pro contato
      final List<Contact> contacts = [];
      for (Map<String, dynamic> map in maps) {
        final Contact contact = Contact(
          map['id'],
          map['name'],
          map['account_number'],
        );
        contacts.add(contact);
      }
      return contacts;
    });
  });
}

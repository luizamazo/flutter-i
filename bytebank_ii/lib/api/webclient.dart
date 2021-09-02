import 'dart:convert';

import 'package:bytebank_ii/models/contact.dart';
import 'package:bytebank_ii/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  //pacote http ja tem funções estáticas; tecnica pra permitir feedback pra conseguir infos precisas
  //da comunicaçao com o http, usa o componente que eh um interceptador
  final Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
  );
  final Response response = await client
      .get(Uri.http('192.168.0.182:8080', 'transactions'))
      .timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];

  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactsJson = transactionJson['contact'];
    transactions.add(
      Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactsJson['name'],
          contactsJson['accountNumber'],
        ),
      ),
    );
  }
  return transactions;
}

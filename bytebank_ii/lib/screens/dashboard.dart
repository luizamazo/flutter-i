import 'package:bytebank_ii/screens/contacts_list.dart';
import 'package:bytebank_ii/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard();
  //Pq usar list view ao inves de singlechild scroll?
  //list view so vai carregar dados a medida q é preciso, qando visto na tela
  //row com single child scroll carrega todo mundo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Container(
            height: 120,
            child: ListView(
              //Pra listview ser vista precisa de um tamannho
              scrollDirection: Axis.horizontal,
              children: [
                _DashboardCard(
                  'Transfer',
                  Icons.monetization_on,
                  onClick: () => _showContactsList(context),
                ),
                _DashboardCard(
                  'Transaction Feed',
                  Icons.description,
                  onClick: () => _showTransferList(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsList(),
      ),
    );
  }

  void _showTransferList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onClick;
  //Function determina callback aqui pra delegar responsabilidade em determinados eventos
  //@required vai avisar quando chamar a funçao que onClick precisa ser impleemntado, tipo onpressed nos btn
  const _DashboardCard(
    this.title,
    this.icon, {
    @required this.onClick,
  })  : assert(icon != null),
        assert(onClick != null);
  //asset irá assegurar que valor x não pode ser nulo
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

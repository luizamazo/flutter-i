import 'package:bytebank_ii/database/dao/contact_dao.dart';
import 'package:bytebank_ii/models/contact.dart';
import 'package:flutter/material.dart';

class ContactsForm extends StatefulWidget {
  const ContactsForm();

  @override
  _ContactsFormState createState() => _ContactsFormState();
}

class _ContactsFormState extends State<ContactsForm> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final ContactDao _dao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fullName,
              decoration: InputDecoration(labelText: 'Full Name'),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _accountNumber,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String fullName = _fullName.text;
                    final int accountNumber = int.tryParse(_accountNumber.text);
                    final Contact newContact =
                        new Contact(0, fullName, accountNumber);
                    _dao.save(newContact).then((id) => Navigator.pop(context));
                  },
                  child: Text('Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

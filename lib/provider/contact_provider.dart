
import 'package:contact_app/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ContactProvider with ChangeNotifier{
  List<Contact> contacts = [];

  Future<void> fetchContacts() async{
    await Future.delayed(const Duration(seconds: 3));
    Uuid uuid = Uuid();

    contacts = [
      Contact(
          id: uuid.v1(),
          name: 'Kyaw Kyaw',
          phones: [
            Phone(uuid.v1(), 'Home', '0984858'),
            Phone(uuid.v1(), 'Office', '094895332')
          ]
      ),
      Contact(
          id: uuid.v1(),
          name: 'Tun Tun',
          phones: [
            Phone(uuid.v1(), 'Home', '049985894'),
            Phone(uuid.v1(), 'Office', '094885933')
          ])
    ];
    notifyListeners();
  }

  void addContact(Contact c){
    contacts.add(c);
    notifyListeners();
  }

  void deleteContact(Contact c){
    contacts.remove(c);
    notifyListeners();
  }

  void updateContact(Contact updatedContact){
    int index = contacts.indexWhere((c)=>c.id == updatedContact.id);
    contacts[index] = updatedContact;
    notifyListeners();
  }
}
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/contact.dart';
import 'manage_contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact App'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ManageContactScreen())
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ContactProvider>(context,listen: false).fetchContacts(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return (Center(child: CircularProgressIndicator(),));
          }else{
            return Consumer<ContactProvider>(
              builder: (context, provider, child) {
                List<Contact> contacts = provider.contacts;
                return ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: contacts.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: GestureDetector(
                          onLongPress: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>ManageContactScreen(contact: contacts[index]))
                            );
                          },
                          child: ExpansionTile(
                            leading: Icon(Icons.person),
                            title: Text(contacts[index].name),
                            trailing: Icon(Icons.phone),
                            children: [
                              for(int i =0;i<contacts[index].phones.length;i++)
                                ListTile(
                                  title: Text(contacts[index].phones[i].phone),
                                  subtitle: Text(contacts[index].phones[i].type),
                                )
                            ],),
                        ),
                      );
                    });
              },
            );
          }
        },

      ),
    );
  }
}

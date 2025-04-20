import 'package:contact_app/model/contact.dart';
import 'package:contact_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ManageContactScreen extends StatefulWidget {
  const ManageContactScreen({this.contact, super.key});
  final Contact? contact;

  @override
  State<ManageContactScreen> createState() => _ManageContactScreenState();
}

class _ManageContactScreenState extends State<ManageContactScreen> {
  final nameController = TextEditingController();
  List<TextEditingController> phoneController = [];
  List<String?> type = [];
  String? selectedType;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.contact != null) {
      Contact c = widget.contact!;
      nameController.text = c.name;
      for (int i = 0; i < c.phones.length; i++) {
        type.add(c.phones[i].type);
        phoneController.add(TextEditingController(text: c.phones[i].phone));
      }
    }
    super.initState();
  }

  Widget buildPhoneForm(int index) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              type.removeAt(index);
              phoneController.removeAt(index);
            },
            icon: Icon(
              Icons.remove_circle,
              color: Colors.redAccent,
            )),
        DropdownButton(
            value: type[index],
            hint: Text('Select Type'),
            underline: SizedBox(),
            items: [
              DropdownMenuItem(value: 'Home', child: Text('Home')),
              DropdownMenuItem(value: 'Personal', child: Text('Personal')),
              DropdownMenuItem(value: 'Office', child: Text('Office')),
            ],
            onChanged: (String? value) {
              setState(() {
                type[index] = value;
              });
            }),
        Expanded(
            child: TextFormField(
          validator: (input) {
            return (input == null || input.isEmpty || input.trim().isEmpty)
                ? 'Enter Phone Number'
                : null;
          },
          controller: phoneController[index],
          decoration: InputDecoration(
              hintText: 'Enter Phone Number', border: InputBorder.none),
        ))
      ],
    );
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final contactProvider =
        Provider.of<ContactProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Manage Contact'),
          actions: [
            if (widget.contact != null)
              IconButton(onPressed: () {
                showDialog(
                    context: context, 
                    builder: (context)=>AlertDialog(
                      title: Text('Deletion Alert!',textAlign: TextAlign.center,),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Are you sure to delete this icon?',textAlign: TextAlign.center,),
                          OverflowBar(
                            children: [
                              TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('No')),
                              TextButton(onPressed: (){
                                contactProvider.deleteContact(widget.contact!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Deleted Contact Successfully')));
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                                  child: Text('Yes'))
                            ],
                          )
                        ],
                      ),
                    ));
              }, icon: Icon(Icons.delete),
                )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (input) {
                      return (input == null ||
                              input.isEmpty ||
                              input.trim().isEmpty)
                          ? 'Enter Your Name'
                          : null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      border: InputBorder.none,
                    ),
                  ),

                  ListView.builder(
                    itemCount: phoneController.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return buildPhoneForm(index);
                    },
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.only(left: 8.0),
                    onTap: (){
                      setState(() {
                        type.add(null);
                        phoneController.add(TextEditingController());
                      });
                    },
                    leading: Icon(Icons.add_call),
                    title: Text('Add Phone'),
                  )
                ],
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(type.contains(null)){ //if null contains condition check
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select the Phone Type'))
                );
              }
              if(formKey.currentState!.validate() && !type.contains(null)){
                bool isUpdate = widget.contact != null;

                Uuid uuid = Uuid();
                Contact newContact = Contact
                  (id: uuid.v1(),
                    name: nameController.text,
                    phones: [
                      for(int i=0;i<type.length;i++)
                        Phone(uuid.v1(), type[i]!, phoneController[i].text)
                    ]);
                isUpdate ? contactProvider.updateContact(newContact) : contactProvider.addContact(newContact);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(isUpdate ? 'Contact Updated Successfully': 'New Contact Added Successfully'))
                  // SnackBar(content: Text('New contact added successfully'))
                );
                Navigator.of(context).pop();
              }
            },
          child: Text('Save'),
        ),
    );
  }
}

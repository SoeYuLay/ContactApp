class Contact{
  String id;
  String name;
  List<Phone> phones;

  Contact({required this.id,required this.name, required this.phones});
}

class Phone{
  String id = '';
  String type = '';
  String phone = '';

  Phone(this.id,this.type,this.phone);
}
import 'package:contact_app/provider_test/num_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinusCard extends StatelessWidget {
  const MinusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      hoverColor: Colors.blue,
      onTap: ()=> Provider.of<NumProvider>(context,listen: false).minus(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text('-',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 48)),
        ),
      ),
    );
  }
}

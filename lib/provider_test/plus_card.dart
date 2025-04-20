import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'num_provider.dart';

class PlusCard extends StatelessWidget {
  const PlusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Provider.of<NumProvider>(context,listen: false).plus(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text('+',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 48)),
        ),
      ),
    );
  }
}

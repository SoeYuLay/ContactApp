import 'package:contact_app/provider_test/plus_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'minus_card.dart';
import 'num_provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<NumProvider>
              (builder: (context,provider,child){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: Text('${provider.num}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 48)),
                  ),
                );
            }),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MinusCard(),
                PlusCard()
              ],
            )
          ],
        ),
      ),
    );
  }
}

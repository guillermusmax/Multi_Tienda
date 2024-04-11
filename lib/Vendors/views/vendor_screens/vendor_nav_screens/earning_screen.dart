import 'package:flutter/material.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Earning", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40 )),
      ),
    );
  }
}

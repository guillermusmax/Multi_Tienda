import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Edit", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40 )),
      ),
    );
  }
}

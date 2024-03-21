import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainVendorScreen extends StatefulWidget {

  MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text("Aprobado"),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              _auth.signOut();
            },
                child: Text('fuera')
            )
          ],
        ),
      ),
    );
  }
}

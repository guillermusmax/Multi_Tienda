import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/vendor_model.dart';
import '../auth/vendor_registration_screen.dart';
import 'main_vendor_screen.dart';


class LandingScreen extends StatefulWidget {
  LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  CollectionReference _vendorsStream = FirebaseFirestore.instance.collection('vendors');

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _vendorsStream.doc(_auth.currentUser!.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        //Revisamos si el vendedor completo el usuario de registro
        if(!snapshot.data!.exists){
          return VendorRegistrationScreen();
        }
        VendorModel vendorModel = VendorModel.fromJson(
          snapshot.data!.data() as Map<String, dynamic>
        );
        if(vendorModel.approve == true){
          return MainVendorScreen();
        }
        //Si llega a este punto, implica que no esta aprovado aun y mostramos un landing
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(vendorModel.image,
                width: 90,
                fit: BoxFit.cover,),
              ),
              SizedBox(
                height: 15,
              ),
              Text(vendorModel.businessName.toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
              ),
              Text("Your profile was sent for Approval"),
            ],
          ),
        );
      },
    );
  }
}

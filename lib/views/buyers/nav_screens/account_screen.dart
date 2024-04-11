import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_tienda/views/buyers/authorization/login_screen.dart';

class AScreen extends StatefulWidget {
  const AScreen({super.key});

  @override
  State<AScreen> createState() => _AScreenState();
}

class _AScreenState extends State<AScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('buyers');
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
              future: users.doc(_auth.currentUser!.uid).get(),
              builder:
                  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
        
                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }
        
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Scaffold(
                    appBar: AppBar(
                      actions: [
                        Icon(CupertinoIcons.moon, color: Colors.white,)
                      ],
                      title: Text('Profile', style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(data['fullName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),
                            ),
                          ),
                          Text(data['email']),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          ListTile(
                          leading: Icon(Icons.settings),
                            title: Text('Settings'),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text('Phone'),
                            subtitle: Text('809'),
                          ),
                          ListTile(
                            leading: Icon(Icons.shopping_cart),
                            title: Text('Cart'),
                          ),
                          InkWell(
                            onTap: () async{
                              await _auth.signOut();
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              },));
                            },
                            child: ListTile(
                              leading: Icon(Icons.logout),
                              title: Text('Logout'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Text("loading");
              },
            );
  }
}

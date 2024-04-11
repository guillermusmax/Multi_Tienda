import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class GeneralTabScreen extends StatefulWidget {
  const GeneralTabScreen({super.key});

  @override
  State<GeneralTabScreen> createState() => _GeneralTabScreenState();
}

class _GeneralTabScreenState extends State<GeneralTabScreen> {

  final  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<String> _categoriesList = [];

  String? _selectedCategory;

  _getCategories() async {
    return _firebaseFirestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot){
          for (var element in querySnapshot.docs){
            setState((){
              _categoriesList.add(element['categoryName']);
            });
          }
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    _getCategories();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: 'Enter Product Name'
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Enter Product Price'
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Enter Product Quantity'
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
              hint: Text("Select Categories"),
                  items: _categoriesList.map((category){
                    return DropdownMenuItem(
                        value: category,
                        child: Text(category));
                  }).toList(),
                  onChanged: (value) {
                    //capturar el valor elegido
                    setState(() {

                    });
                    //_selectedCategory = value;
                  },
                dropdownColor: Colors.grey,
                decoration: InputDecoration(
                  filled: true,
                  hoverColor: Colors.blue,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),

              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 200,
                maxLines: 8,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Enter Product Description'
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: (){
                        showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(5000),
                        );
                      },
                      child: Text('Schedule',
                      style: TextStyle(
                        color: Colors.red
                      ),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/vendor_register_controller.dart';

class VendorRegistrationScreen extends StatefulWidget {
  VendorRegistrationScreen({super.key});

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final VendorController _vendorController = VendorController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String stateValue;
  late String countryValue;
  late String cityValue;
  Uint8List? image;
  List<String> _taxOptions = ['YES', 'NO'];
  String taxTypeSelection = "NO";

  late String businessName;
  late String emailAddress;
  late String phoneNumber;
  String rncNumber = '';

  selectGalleryImage() async {
    Uint8List? im = await _vendorController.pickStoreImage(ImageSource.gallery);

    setState(() {
      image = im;
    });
  }


  _saveVendorDetails() async {
    EasyLoading.show(status: 'Please Wait');
    if (_formKey.currentState!.validate())  {
      String res = await _vendorController.registerVendor(
          businessName,
          emailAddress,
          phoneNumber,
          countryValue,
          stateValue,
          cityValue,
          taxTypeSelection,
          rncNumber,
          image).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
        });
      });
      print(res);
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green.shade900,
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade900, Colors.lightBlueAccent],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: IconButton(
                                icon: image != null
                                    ? Image.memory(
                                  image!,
                                  fit: BoxFit.cover,
                                )
                                    : Icon(CupertinoIcons.photo),
                                onPressed: () {
                                  selectGalleryImage();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Business Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Field';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        businessName = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Field';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        emailAddress = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Field';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                    ),
                    SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax Registered?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        Flexible(
                          child: Container(
                            width: 200,
                            child: DropdownButtonFormField(
                              hint: Text("Please Select"),
                              items: _taxOptions.map((value) {
                                return DropdownMenuItem(
                                  //alignment: Alignment.bottomRight,
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  if(value != null){
                                    taxTypeSelection = value;
                                  }
                                  else{
                                    taxTypeSelection = 'NO';
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (taxTypeSelection == "YES")
                      TextFormField(
                        decoration: InputDecoration(labelText: "RNC"),
                        onChanged: (value) {
                          rncNumber = value;
                        },
                      ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        _saveVendorDetails();
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.green.shade900,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: Text('Logout'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

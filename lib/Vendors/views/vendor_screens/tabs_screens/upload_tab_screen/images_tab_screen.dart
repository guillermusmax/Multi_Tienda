import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../controllers/vendor_register_controller.dart';

class ImagesTabScreen extends StatefulWidget {
  const ImagesTabScreen({super.key});

  @override
  State<ImagesTabScreen> createState() => _ImagesTabScreenState();
}

class _ImagesTabScreenState extends State<ImagesTabScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  List<Uint8List?> _image = [];
  List<String> _imageUrls = [];

  Uint8List? image;

  // _uploadProductImagesToStorage(Uint8List image) async {
  //     Reference ref =
  //         _firebaseStorage.ref().child('uploadtabImages').child(const Uuid().v4());
  //     UploadTask uploadTask = ref.putData(image);
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //     return downloadUrl;
  // }
  _pickImage() async {
    FilePickerResult? results = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (results != null) {
      setState(() {
        for (var image in results.files) {
          _image.add(image.bytes);
        }
      });
    } else {}
  }
  // selectGalleryImage() async {
  //   Uint8List? im =
  //       await _vendorControllerTab.pickStoreImage(ImageSource.gallery);
  //   setState(() {
  //     image = im;
  //   });
  // }

  _uploadProductsImagesToStorage() async {
    for (var image in _image) {
      Reference ref =
      _firebaseStorage.ref().child('storeImage').child(const Uuid().v4());
      await ref.putData(image!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          setState(() {
            _imageUrls.add(value);
          });
        });
      });
    }
  }
  //
  // _saveImageToStorage() async {
  //   EasyLoading.show(status: 'Please Wait');
  //   if (_formKey.currentState!.validate()) {
  //     String res =
  //         await _vendorControllerTab.UploadImage(image).whenComplete(() {
  //       EasyLoading.dismiss();
  //       setState(() {
  //         _formKey.currentState!.reset();
  //       });
  //     });
  //     print(res);
  //   } else {
  //     print('Error');
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _image.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            _pickImage();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.memory(
                        _image[index - 1]!,
                        fit: BoxFit.cover,
                      ),
                    );
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            style: ButtonStyle(
              alignment: AlignmentDirectional.center,
            ),
            onPressed: () {
              _uploadProductsImagesToStorage();
            },
            child: Text(
              'Guardar',
              style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

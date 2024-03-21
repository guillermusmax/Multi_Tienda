import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';

class VendorController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);

    if(_file != null){
      return await _file.readAsBytes();
    }else{
      print("No image selected");
    }
  }
  // login
  // Future<void> logInValidation(String email, String password) async{
  //   await _firebaseFirestore.collection('buyers')
  //       .get('email': email,password)
  // }
  //registrar usuario
  _uploadVendorImageToStorage(Uint8List image) async {
    Reference ref = _firebaseStorage
        .ref().child('storeImage').child(_firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<String> registerVendor(
      String businessName,
      String emailAddress,
      String phoneNumber,
      String countryValue,
      String stateValue,
      String cityValue,
      String taxTypeSelection,
      String rncNumber,
      Uint8List? image,
      ) async {
    String response = 'Holy Molly, something bad happen JAJAJAJ';

    try {
      String uploadedImage = await _uploadVendorImageToStorage(image!);
      //guarda el usuario en la base de datos
      await _firebaseFirestore.collection('vendors').doc(_firebaseAuth.currentUser!.uid).set(
        {
          'vendorId': _firebaseAuth.currentUser!.uid,
          'businessName': businessName,
          'email': emailAddress,
          'phoneNumber': phoneNumber,
          'country': countryValue,
          'state': stateValue,
          'city': cityValue,
          'taxTypeSelection': taxTypeSelection,
          'rnc': rncNumber,
          'image': uploadedImage,
          'approve': false,
        }
      );
      response = "Data Saved";
    }
    catch (e) {
      response = e.toString();
      EasyLoading.dismiss();
    }
    return response;
  }

  Future<String> LoginUser(String email, String password) async{
    String respuesta = "Something went wrong";

    try{
      UserCredential _userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      respuesta = 'sucess';
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        respuesta = "user-not-found";
      }else if (e.code == 'wrong-password') {
        respuesta = "Wrong password";
      }
    }
    catch (e){
      respuesta = e.toString();
    }
    return respuesta;
  }
}
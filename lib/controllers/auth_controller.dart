import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // login
  // Future<void> logInValidation(String email, String password) async{
  //   await _firebaseFirestore.collection('buyers')
  //       .get('email': email,password)
  // }
  //registrar usuario

Future<String> registerUser(
    String email,
    String name,
    String password
    ) async {
  String response = 'Holy Molly, something bad happen JAJAJAJ';

  try {
    UserCredential _userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    //guarda el usuario en la base de datos
    await _firebaseFirestore.collection('buyers')
        .doc(_userCredential.user!.uid)
        .set({
      'fullName': name,
      'profileImage': "",
      'email': email,
      'uid': _userCredential.user!.uid,
      'pinCode': "",
      'locally': "",
      'city': "",
      'state': "",
    });

    response = "Data Saved";
  }
  catch (e) {
    response = e.toString();
  }
  return response;
}

Future<String> LoginUser(String email, String password) async{
  String respuesta = "Something went wrong";

  try{
    UserCredential _userCredential= await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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
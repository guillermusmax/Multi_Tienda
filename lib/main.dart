import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/main_vendor_screen.dart';
import 'package:multi_tienda/controllers/banner_controller.dart';
import 'package:multi_tienda/controllers/category_controller.dart';
import 'package:multi_tienda/views/buyers/authorization/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //asegurarse de que todos los widgets se hayan inicializado
  Platform.isAndroid ? await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyC_HOagxOO6i6tGZVUXHgrlfa_C525KtOM",
        appId: "1:637973204443:android:0b5164f91bee06685e2bfe",
        messagingSenderId: "637973204443",
        projectId: "multi-store-v2-bb18f",
      storageBucket: "gs://multi-store-v2-bb18f.appspot.com"
    )
  ) : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tienda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
      initialBinding: BindingsBuilder((){
        Get.put<CategoryController>(CategoryController());
        Get.put<BannerController>(BannerController());
      }),
    );
  }
}

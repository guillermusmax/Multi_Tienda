import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tienda/controllers/banner_controller.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {

  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  // List _bannerList = []; //almacenar todos los banner que vamos a mostrar

  //metodo para traer los banners desde firestore (base de datos)

  // getBanner(){
  //   return _firebaseFirestore.collection('banners')
  //       .get()
  //       .then((QuerySnapshot querySnapshot){
  //         querySnapshot.docs.forEach((doc) {
  //           setState(() {
  //             _bannerList.add(doc['image']);
  //           });
  //         });
  //   });
  // }

  //carga la lista cuando se inserte el widget en el arbol

  // void initState(){
  //   // TODO: impelement initState
  //   super.initState();
  //   // getBanner();
  // }
  final BannerController _bannerController = Get.find<BannerController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 120,
            width: double.infinity,
            child: PageView.builder(
              itemCount: _bannerController.banners.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: _bannerController.banners[index],
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            // colorFilter:
                            // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                          ),
                        ),
                      ),
                  placeholder: (context, url) =>
                      Shimmer(
                        // This is the ONLY required parameter
                        child: Container(
                          color: Colors.deepPurple,
                        ),
                        // This is the default value
                        duration: Duration(seconds: 3),
                        // This is NOT the default value. Default value: Duration(seconds: 0)
                        interval: Duration(seconds: 5),
                        // This is the default value
                        color: Colors.white,
                        // This is the default value
                        colorOpacity: 0.3,
                        // This is the default value
                        enabled: true,
                        // This is the default value
                        direction: ShimmerDirection.fromLTRB(),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

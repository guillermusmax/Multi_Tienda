import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:multi_tienda/models/category_model.dart';

class CategoryController extends GetxController{
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //Lista reactiva RxList
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  //obs cuando se realize un cambio en la categoria se lo va a notificar a la lista y se actualizara sola
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fetchCategories();
  }

void _fetchCategories(){
 _firebaseFirestore
     .collection('categories')
     .snapshots()//tirarle una foto a toda la info que hay
     .listen((QuerySnapshot querySnapshot)
 {
       categories.assignAll(
         querySnapshot.docs.map((doc){//crea un mapa donde estan todos los valores
           final data = doc.data() as Map<String, dynamic>;
           return CategoryModel(//una lista que tiene un tipo de categoria
               categoryName: data['categoryName'],
               categoryImage: data['categoryImage']);
         }).toList(),
       );
 });
}
}
import 'package:flutter/material.dart';
import 'package:multi_tienda/views/buyers/nav_screens/main_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
         appBar: AppBar(
           title: Text('Cart'),
         ),
         body: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('Your Cart is Empty',
                     style: TextStyle(
                letterSpacing: 5,
                fontSize: 25,
                fontWeight: FontWeight.bold
                     ),
                     ),
               Padding(padding: EdgeInsets.all(20),
               child: InkWell(
                 onTap: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                     return Mainscreen();
                   },));
                 },
                 child: Container(
                   width: double.infinity,
                   height: 50,
                   decoration: BoxDecoration(
                     color: Colors.blue,
                     borderRadius: BorderRadius.circular(10)
                   ),
                 ),
               ),
               ),
             ],
           ),
         ),
       );
  }
}

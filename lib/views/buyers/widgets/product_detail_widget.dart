import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailWidget extends StatelessWidget {
  final QueryDocumentSnapshot productData;

  const ProductDetailWidget({required this.productData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    productData['productName'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    '  4.5',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.orange,
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 200,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Positioned(
                    left: 25,
                    top: 0,
                    child: ClipRect(
                      child: Container(
                        width: 150,
                        height: 180,
                        child: Image.network(
                          productData['productImages'][0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${productData['productDiscount']}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '\$${productData['productPrice']}',
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                productData['category'],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(height: 16),
            Padding(
                padding: EdgeInsets.all(8),
              child: Text(
                productData['category'],
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Size:',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black54
                  ),
                  ),
                  ListView.builder(
                    itemCount: productData['productSize'].length,
                    scrollDirection:  Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius:
                                    BorderRadius.circular(5.0)
                                ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  productData['productSize'][index],
                                  style: GoogleFonts.lato(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text("Descripcion:"),
                Text(productData['productDescripcion'])
              ],
            ),),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color:  Colors.blueGrey,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: Text('Add to Cart',
          style:  GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),)),
        ),
      ),
    );
  }
}

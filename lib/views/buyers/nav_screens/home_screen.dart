import 'package:flutter/material.dart';
import 'package:multi_tienda/views/buyers/widgets/banner_widget.dart';
import 'package:multi_tienda/views/buyers/widgets/category_item.dart';
import 'package:multi_tienda/views/buyers/widgets/header_screen.dart';
import 'package:multi_tienda/views/buyers/widgets/product_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header_Screen(),
            BannerWidget(),
            CategoryItem(),
            ProductWidget()
          ],
        ),
      ),
    );
  }
}

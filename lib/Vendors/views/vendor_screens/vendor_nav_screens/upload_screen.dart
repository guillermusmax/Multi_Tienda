import 'package:flutter/material.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/tabs_screens/upload_tab_screen/attributes_tab_screen.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/tabs_screens/upload_tab_screen/general_tab_screen.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/tabs_screens/upload_tab_screen/images_tab_screen.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/tabs_screens/upload_tab_screen/shipping_tab_screen.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Upload",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          bottom: TabBar(tabs: [
            Tab(
              child: Text('General'),
            ),
            Tab(
              child: Text('Shipping'),
            ),
            Tab(
              child: Text('Attributes'),
            ),
            Tab(
              child: Text('Images'),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            GeneralTabScreen(),
            ShippingTabScreen(),
            AttributesTabScreen(),
            ImagesTabScreen()
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/vendor_nav_screens/earning_screen.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/vendor_nav_screens/edit_screen.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/vendor_nav_screens/logout.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/vendor_nav_screens/order_screen.dart';
import 'package:multi_tienda/Vendors/views/vendor_screens/vendor_nav_screens/upload_screen.dart';

class MainVendorScreen extends StatefulWidget {

  MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  int _currentPage = 0;
  List<Widget> _pages = [
    EarningScreen(),
    EditScreen(),
    OrderScreen(),
    UploadScreen(),
    LogoutScreen(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (value){
          setState(() {
            _currentPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),
              label: 'Earnings'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.star),
              label: 'Edit'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bag_fill),
              label: 'Order'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Upload'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),
              label: 'Logout'
          ),
        ],
      ),
      body: _pages[_currentPage],
    );
  }
}

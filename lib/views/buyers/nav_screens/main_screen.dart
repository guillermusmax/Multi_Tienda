import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_tienda/views/buyers/nav_screens/cart_screen.dart';
import 'package:multi_tienda/views/buyers/nav_screens/category_screen.dart';
import 'package:multi_tienda/views/buyers/nav_screens/home_screen.dart';
import 'package:multi_tienda/views/buyers/nav_screens/search_screen.dart';
import 'package:multi_tienda/views/buyers/nav_screens/store_screen.dart';
import 'package:multi_tienda/views/buyers/nav_screens/account_screen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen ({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _currentPage = 0;
  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    AScreen()
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
          label: 'Home'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.star),
              label: 'Favorites'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bag_fill),
              label: 'Store'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Cart'
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),
              label: 'Account'
          ),
        ],
      ),
      body: _pages[_currentPage],
    );
  }
}

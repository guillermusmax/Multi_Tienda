import 'package:flutter/material.dart';

class Header_Screen extends StatelessWidget {
  const Header_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/icons/searchBanner.jpeg',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 48,
          top: 68,
          child: SizedBox(
            width: 250,
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'enter here',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  prefixIcon: Image.asset('assets/icons/search.png'),
                  suffixIcon: Image.asset('assets/icons/camera.png'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
        ),
        Positioned(
          left: 354,
          top: 75,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              overlayColor: MaterialStateProperty.all(Color(0xFF0C7F7F)),
              child: Ink(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/message.png'),
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}

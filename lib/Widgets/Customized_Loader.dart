import 'dart:async';

import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  int _currentIndex = 0;
  List<String> _images = [
    'assets/icons/Vector (8).png',
    'assets/icons/CSI LOGO 2nd.png',
    'assets/icons/CSI LOGO1.png',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: SizedBox(
          width: 100, 
          height: 100,
          child: Image.asset(
            _images[_currentIndex],
            key: ValueKey<int>(_currentIndex),
          ),
        ),
      ),
    );
  }
}

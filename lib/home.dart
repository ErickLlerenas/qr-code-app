import 'package:flutter/material.dart';
import 'package:qr_code_scanner_reader_and_generator/pages/generator.dart';
import 'package:qr_code_scanner_reader_and_generator/pages/scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List _widgetOptions = [
    Scanner(),
    Generator(),
    // Text('Index 3: School'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.camera),
              label: 'Scanner',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.pencilAlt),
              label: 'Generator',
            ),
            // BottomNavigationBarItem(
            //   icon: FaIcon(FontAwesomeIcons.ad),
            //   label: 'Ads',
            // ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 0, 53, 153),
          onTap: _onItemTapped,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}

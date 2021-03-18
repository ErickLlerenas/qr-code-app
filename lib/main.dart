import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner_reader_and_generator/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Scanner',
      home: Home(),
    );
  }
}

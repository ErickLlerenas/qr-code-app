import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner_reader_and_generator/pages/createQR.dart';
import 'package:qr_code_scanner_reader_and_generator/widgets/QRIcon.dart';

class Generator extends StatefulWidget {
  @override
  _GeneratorState createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  String name = "Text";
  Color color = Color.fromARGB(255, 0, 53, 123);
  TextEditingController qrController = TextEditingController();

  void getData(String newName, Color newColor) {
    setState(() {
      name = newName;
      color = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        padding: EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create QR\n',
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Choose one template to start creating a QR Code.\n\n\n",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            Wrap(
              children: [
                QRIcon(
                    icon: FontAwesomeIcons.amilia,
                    name: "Text",
                    color: Color.fromARGB(255, 0, 53, 123),
                    getData: getData),
                QRIcon(
                    icon: FontAwesomeIcons.link,
                    name: "URL",
                    color: Colors.orange,
                    getData: getData),
                QRIcon(
                    icon: FontAwesomeIcons.phone,
                    name: "Phone",
                    color: Colors.amber,
                    getData: getData),
                QRIcon(
                    icon: FontAwesomeIcons.facebookF,
                    name: "Facebook",
                    color: Colors.blue,
                    getData: getData),
                QRIcon(
                    icon: FontAwesomeIcons.whatsapp,
                    name: "Whatsapp",
                    color: Colors.green,
                    getData: getData),
                QRIcon(
                    icon: FontAwesomeIcons.instagram,
                    name: "Instagram",
                    color: Colors.pink,
                    getData: getData),
              ],
            ),
            SizedBox(height: 50),
            ButtonTheme(
              height: 50,
              child: FlatButton(
                minWidth: double.infinity,
                color: color,
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateQR(color: color, name: name)),
                    );
                  });
                },
                child: Text('Create $name QR Code',
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      )),
    );
  }
}

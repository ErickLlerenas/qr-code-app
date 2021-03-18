import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';
import 'package:toast/toast.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Future scanQR() async {
    String result = await scanner.scan();
    print(result);
    if (result.startsWith('http')) {
      _showURLDialog(result);
    } else if (result.startsWith('tel:')) {
      _showPhoneDialog(result);
    } else {
      _showTextDialog(result);
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _showURLDialog(String url) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "¿Open this site?",
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: url.length / 1.5 + 100.0,
            child: Column(
              children: [
                Text(
                  "$url",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  color: Color.fromARGB(255, 0, 53, 153),
                  child: Text(
                    "Open",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _launchURL(url);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTextDialog(String text) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Text",
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: text.length + 100.0,
            child: Column(
              children: [
                Text(
                  "$text",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  color: Color.fromARGB(255, 0, 53, 153),
                  child: Text(
                    "Copy",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    FlutterClipboard.copy('$text').then((value) => Toast.show(
                        "Texto copied", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPhoneDialog(String phone) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Phone",
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: phone.length / 1.5 + 100.0,
            child: Column(
              children: [
                Text(
                  "${phone.replaceAll('tel:', '')}",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  color: Color.fromARGB(255, 0, 53, 153),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _launchURL(phone);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(60),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scan QR\n',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Place the QR Code inside the frame to scan it.\n\n\n",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              Image.asset('assets/qr.png', height: 300),
              SizedBox(
                height: 50,
              ),
              ButtonTheme(
                minWidth: double.infinity,
                height: 50,
                child: FlatButton(
                  color: Color.fromARGB(255, 0, 53, 153),
                  child: Text('Start Scanner',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    await scanQR();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

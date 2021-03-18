import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:toast/toast.dart';
import 'package:country_code_picker/country_code_picker.dart';

class CreateQR extends StatefulWidget {
  final Color color;
  final String name;

  CreateQR({this.color, this.name});
  @override
  _CreateQRState createState() => _CreateQRState();
}

class _CreateQRState extends State<CreateQR> {
  Uint8List bytes = Uint8List(0);
  String code = "+52";
  TextEditingController qrController = TextEditingController();

  Future _generateBarCode(String inputCode) async {
    if (widget.name == "Phone") {
      inputCode = "tel:" + inputCode;
    }
    if (widget.name == "Whatsapp") {
      inputCode = "https://wa.me/" + code + inputCode;
    }
    if (widget.name == "Instagram") {
      inputCode = "https://instagram.com/" + inputCode;
    }
    
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }

  Future saveImage(String text,BuildContext context) async {
    print(widget.name);
    print(text);
    var result;
    if(widget.name=="Facebook" || widget.name == "URL"){
        result = await ImageGallerySaver.saveImage(this.bytes,
      name: "QR${widget.name}", quality: 75);
    }else{
      result = await ImageGallerySaver.saveImage(this.bytes,
        name: "QR${widget.name}$text", quality: 75);
      
    }
   
    
    
    if(result['filePath']!=null){
      Toast.show("Image saved at ${result['filePath']}", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }else{
      Toast.show("Error saving the QR image", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }

    setState(() {
      qrController.text = "";
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text("Create ${widget.name} QR Code"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(60),
            child: Column(
              children: [
                Text(
                  'QR Code generator\n',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Complete the field to create a ${widget.name} QR Code. You can also save it to gallery.\n\n\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                qrController.text.length > 0
                    ? Column(children: [
                        QrImage(
                          data: qrController.text,
                          version: QrVersions.auto,
                          size: 200.0,
                          foregroundColor: widget.color,
                        ),
                        OutlineButton(
                          borderSide: BorderSide(color: widget.color),
                          child: Text(
                            'Save to gallery',
                            style: TextStyle(color: widget.color),
                          ),
                          onPressed: () {
                            saveImage(qrController.text,context);
                          },
                        )
                      ])
                    : Container(),
                SizedBox(height: 40),
                widget.name == "Whatsapp"
                    ? CountryCodePicker(
                        onChanged: (CountryCode newCode) {
                          setState(() {
                            code = newCode.toString();
                          });
                        },
                        initialSelection: 'MX',
                      )
                    : Container(),
                TextFormField(
                  keyboardType:
                      (widget.name == "Whatsapp" || widget.name == "Phone")
                          ? TextInputType.number
                          : TextInputType.text,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300])),
                      hintText:
                          (widget.name == "Whatsapp" || widget.name == "Phone")
                              ? "Write a phone number ..."
                              : widget.name == "URL"
                                  ? "Write some URL ..."
                                  : widget.name == "Facebook"
                                      ? "Write the Facebook URL ..."
                                      : widget.name == "Instagram"
                                          ? "Write the Instagram user name ..."
                                          : "Write some text ..."),
                  controller: qrController,
                ),
                SizedBox(height: 50),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 50,
                  child: FlatButton(
                      color: widget.color,
                      onPressed: () {
                        _generateBarCode(qrController.text);
                        setState(() {});
                      },
                      child: Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QRIcon extends StatefulWidget {
  final IconData icon;
  final String name;
  final Color color;
  final Function getData;

  QRIcon({this.icon, this.name, this.color, this.getData});
  @override
  _QRIconState createState() => _QRIconState();
}

class _QRIconState extends State<QRIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: widget.color,
            child: IconButton(
              color: Colors.white,
              icon: FaIcon(widget.icon),
              onPressed: () {
                widget.getData(widget.name, widget.color);
              },
            ),
          ),
          Text(widget.name)
        ],
      ),
    );
  }
}

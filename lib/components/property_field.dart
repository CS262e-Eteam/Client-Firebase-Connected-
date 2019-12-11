/*
Implements a property field
@params: title, string: the label to use for the property tag (used to determine the icon)
         value, string: the value of the property
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PropertyField extends StatefulWidget {
  final String title;
  final String value;

  PropertyField({Key key, this.title, this.value});

  @override
  PropertyFieldState createState() => PropertyFieldState();
}

class PropertyFieldState extends State<PropertyField> {

  Widget _getIcon() {
    if (widget.title == "CONDITION") {
      return Icon(
        FontAwesomeIcons.clipboardCheck,
        color: Colors.white,
      );
    } else if (widget.title == "AUTHOR") {
      return Icon(
        FontAwesomeIcons.user,
        color: Colors.white,
      );
    } else if (widget.title == "CLASS") {
      return Icon(
        FontAwesomeIcons.chalkboard,
        color: Colors.white,
      );
    } else if (widget.title == "ISBN") {
      return Icon(
        FontAwesomeIcons.barcode,
        color: Colors.white,
      );
    } else if (widget.title == "BRAND") {
      return Icon(
        FontAwesomeIcons.tag,
        color: Colors.white,
      );
    } else if (widget.title == "SIZE") {
      return Icon(
        FontAwesomeIcons.tshirt,
        color: Colors.white,
      );
    } else {
      return Icon(
        FontAwesomeIcons.square,
        color: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
          children: <Widget>[
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xFFAEB6C0),
                    borderRadius: BorderRadius.all(
                        Radius.circular(40)
                    )
                ),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: _getIcon(),
                )
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                ),
                Text(
                    widget.value,
                    style: TextStyle(
                        fontSize: 16
                    )
                ),
              ],
            )
          ]
      )
    );
  }
}
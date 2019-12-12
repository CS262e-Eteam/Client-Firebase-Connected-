/*
Implements a favorite heart that can be selected/deselected and the fill changes based on that
@params: itemId, int: the itemId which is used to check what display
                      (favorited or not) to initialize the heart to
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lab09/shared/colors.dart' as colors;
import 'package:lab09/shared/globals.dart' as globals;

class FavoriteHeart extends StatefulWidget {
  FavoriteHeart({Key key, this.itemId}) : super(key: key);

  final String itemId;

  @override
  FavoriteHeartState createState() => FavoriteHeartState();
}

class FavoriteHeartState extends State<FavoriteHeart> {
  @override
  Widget build(BuildContext context) {
    return globals.user != null ? GestureDetector(
        onTap: () {
          if (globals.user.favoritedItems.contains(widget.itemId)) {
            globals.user.favoritedItems.remove(widget.itemId);
          } else {
            globals.user.favoritedItems.add(widget.itemId);
          }

          Firestore.instance.collection('users').document(globals.user.reference.documentID).updateData({
            'favoritedItems': globals.user.favoritedItems
          });
          setState(() {});
        },
        child: Container(
            alignment: Alignment.bottomRight,
            child: globals.user.favoritedItems.contains(widget.itemId) ?
            Icon(
              FontAwesomeIcons.solidHeart,
              color: colors.lightestBerry,
            ) :
            Icon(
                FontAwesomeIcons.heart
            )
        )
    ) : Container();
  }
}
/*
Implements a favorite heart that can be selected/deselected and the fill changes based on that
@params: itemId, int: the itemId which is used to check what display
                      (favorited or not) to initialize the heart to
 */

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
    return GestureDetector(
        onTap: () {
          if (globals.testUser.favoritedItems.contains(widget.itemId)) {
            globals.testUser.favoritedItems.remove(widget.itemId);
          } else {
            globals.testUser.favoritedItems.add(widget.itemId);
          }
          setState(() {});
        },
        child: Container(
            alignment: Alignment.bottomRight,
            child: globals.testUser.favoritedItems.contains(widget.itemId) ?
            Icon(
              FontAwesomeIcons.solidHeart,
              color: colors.lightestBerry,
            ) :
            Icon(
                FontAwesomeIcons.heart
            )
        )
    );
  }
}
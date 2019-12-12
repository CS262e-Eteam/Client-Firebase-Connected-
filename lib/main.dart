/*
Main - provides a framework for the app that includes the app bar containing the menu
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lab09/pages/edit_item.dart';
import 'package:lab09/pages/filter_list.dart';
import 'package:lab09/pages/home_page.dart';
import 'package:lab09/types/item.dart';
import 'pages/login_page.dart';
import 'pages/user_settings.dart';

import 'shared/globals.dart' as globals;
import 'shared/colors.dart' as colors;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('items').orderBy('createdDate', descending: true).snapshots(),
      builder: (context, snapshot) {
        globals.items = [];
        if (!snapshot.hasData) return LinearProgressIndicator();
        snapshot.data.documents.forEach((snap) {
          Item item = Item.fromSnapshot(snap);
          globals.items.add(item);
        });
        return HomePage();
      },
    );
  }

}

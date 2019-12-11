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

  List<Widget> menuTabs(BuildContext context) {
    List<Widget> tabs = [
      DrawerHeader(
          decoration: BoxDecoration(
            color: colors.grayBlue,
          ),
          child: Stack(children: <Widget>[
            Align(alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                )
            ),
            Text(globals.appName,
                style: TextStyle(fontSize: 30) ),
          ],)
      ),
      ListTile(
        leading: Icon(Icons.bookmark_border),
        title: Text('All Items'),
        onTap: (){
          Navigator.pop(context);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new FilterList(filter: "All Items")),
          );
        },
      ),
      ListTile(
        leading: Icon(FontAwesomeIcons.bookOpen),
        title: Text('Textbooks'),
        onTap: (){
          Navigator.pop(context);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new FilterList(filter: "Textbook")),
          );
        },
      ),
      ListTile(
        leading: Icon(FontAwesomeIcons.tshirt),
        title: Text('Clothing'),
        onTap: (){
          Navigator.pop(context);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new FilterList(filter: "Clothing")),
          );
        },
      ),
      ListTile(
        leading: Icon(FontAwesomeIcons.heart),
        title: Text('Favorited Items'),
        onTap: (){
          Navigator.pop(context);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new FilterList(filter: "Favorited")),
          );
        },
      ),
      ListTile(
        leading: Icon(FontAwesomeIcons.shirtsinbulk),
        title: Text('My Items'),
        onTap: (){
          Navigator.pop(context);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new FilterList(filter: "My Items")),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.add),
        title: Text('Add Item'),
        onTap: (){
          Navigator.pop(context);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new ItemForm( item: null )),
          );
        },
      ),
    ];

//    if (globals.isLoggedIn) {
    tabs.add(
      ListTile(
        leading: Icon(FontAwesomeIcons.userCircle),
        title: Text('Login'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new LoginPage()),
          );
        },
      ),
    );
//    } else {
      tabs.add(
        ListTile(
          leading: Icon(FontAwesomeIcons.userCircle),
          title: Text('My Account'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new UserSettings()),
            );
          },
        ),
      );
//
//      tabs.add(
//        ListTile(
//          leading: Icon(FontAwesomeIcons.doorOpen),
//          title: Text('Logout'),
//          onTap: (){//fucntion we need
//            globals.isLoggedIn = false;
//          },
//        ),
//      );
//    }

    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: colors.grayBlue,
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {
//              showSearch(
//                context: context,
//  //                      delegate: CustomSearchDelegate()
//              );
//            },
//          ),
//        ],
//      ),
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: menuTabs(context)
        ) ,
      ),

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

//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      drawer: Drawer(
//        child: ListView(
//            padding: EdgeInsets.zero,
//            children: menuTabs(context)
//        ) ,
//      ),
//      body: HomePage(),
//    );
//  }
}

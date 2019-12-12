/*
Implements a favorite heart that can be selected/deselected and the fill changes based on that
@params: itemId, int: the itemId which is used to check what display
                      (favorited or not) to initialize the heart to
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lab09/pages/edit_item.dart';
import 'package:lab09/pages/filter_list.dart';
import 'package:lab09/pages/home_page.dart';
import 'package:lab09/pages/login_page.dart';

import 'package:lab09/shared/colors.dart' as colors;
import 'package:lab09/shared/globals.dart' as globals;

class MenuTabs extends StatefulWidget {
  MenuTabs({Key key}) : super(key: key);

  @override
  MenuTabsState createState() => MenuTabsState();
}

class MenuTabsState extends State<MenuTabs> {
  List<Widget> menuTabs(BuildContext context) {
    List<Widget> tabs = [
      DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Stack(children: <Widget>[
            Align(alignment: Alignment.bottomCenter,
                child: new Container(
                  width: 90.0,
                  height: 90.0,
                  alignment: Alignment.bottomLeft ,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: new AssetImage(
                            'lib/images/calvincircle.jpg',)
                      )
                  ),
                )
            ),

          ],)
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: (){
          Navigator.pop(context);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new HomePage()),
          );
        },
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
    ];

//    if (globals.isLoggedIn) {
    if (globals.user == null) {
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
    } else {
//      tabs.add(
//        ListTile(
//          leading: Icon(FontAwesomeIcons.userCircle),
//          title: Text('My Account'),
//          onTap: (){//fucntion we need
//          },
//        ),
//      );
//

      tabs.add(
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
      );
      tabs.add(
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
      );
      tabs.add(
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
      );
      tabs.add(
        ListTile(
          leading: Icon(FontAwesomeIcons.doorOpen),
          title: Text('Logout'),
          onTap: (){//fucntion we need
            globals.user = null;
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new HomePage())
            );
          },
        ),
      );
    }

    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: menuTabs(context)
      ) ,
    );
  }
}
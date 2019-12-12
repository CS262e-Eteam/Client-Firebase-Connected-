/*
Home Page - shows header and list of most recent items
 */

import 'package:flutter/material.dart';
import 'package:lab09/components/menu_tabs.dart';
import 'package:lab09/components/summary_card.dart';
import 'package:lab09/types/item.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'package:lab09/shared/globals.dart' as globals;
import 'package:lab09/shared/colors.dart' as colors;

class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  List<Widget> searchResults = [];
  final itemName = TextEditingController();
  FocusNode itemNameNode = new FocusNode();

  void searchItems() {
    searchResults = [];
    List<Item> foundItems = [];

    globals.items.forEach((item) {
      if (item.name.toLowerCase().contains(itemName.text.toLowerCase())) {
        foundItems.add(item);
      }
    });

    globals.items.forEach((item) {
      if (item.course != null && item.course.toLowerCase().contains(itemName.text.toLowerCase()) && !foundItems.contains(item)) {
        foundItems.add(item);
      }
    });

    globals.items.forEach((item) {
      if (item.gender != null && item.gender.toLowerCase().contains(itemName.text.toLowerCase()) && !foundItems.contains(item)) {
        foundItems.add(item);
      }
    });

    globals.items.forEach((item) {
      if (item.description != null && item.description.toLowerCase().contains(itemName.text.toLowerCase()) && !foundItems.contains(item)) {
        foundItems.add(item);
      }
    });

    globals.items.forEach((item) {
      if (item.category != null && item.category.toLowerCase().contains(itemName.text.toLowerCase()) && !foundItems.contains(item)) {
        foundItems.add(item);
      }
    });

    foundItems.forEach((item) {
      searchResults.add(SummaryCard(item: item, isSeller: false));
    });

    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ResponsiveGridCol> homePageLayout() {
      List<ResponsiveGridCol> grid = [
        ResponsiveGridCol(
            lg: 12,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 1.5, color: colors.lightBerry),
                )
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        controller: itemName,
                        focusNode: itemNameNode,
                        validator: (value) {
                          if (value.isEmpty) return "Please enter a name";
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        cursorColor: colors.lightBerry,
                        decoration: InputDecoration(
                          labelText: "Search for...",
                          labelStyle: TextStyle(
                              color: itemNameNode.hasFocus ? colors.lightBerry : Colors.black
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: colors.lightBerry),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5)
                    ),
                    IconButton(icon: Icon(Icons.search, color: colors.darkGrayBlue),
                      onPressed: () {
                        searchItems();
                      },
                    ),
                  ]
                ),

              ),
            )
        )
      ];

      searchResults.forEach((sC) {
        grid.add(
            ResponsiveGridCol(
                xs: 6,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: sC
                )
            )
        );
      });

      return grid;
    }

    return new Scaffold(
        appBar: new AppBar(
          title: Text("Search"),
          backgroundColor: colors.grayBlue,
        ),
        drawer: MenuTabs(),
        body: SingleChildScrollView(
          child: Container(
              color: colors.lightestGrayBlue,
              child: ResponsiveGridRow (
                children: homePageLayout(),
              )
          ),
        )
    );

  }
}
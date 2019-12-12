/*
Home Page - shows header and list of most recent items
 */

import 'package:flutter/material.dart';
import 'package:lab09/components/menu_tabs.dart';
import 'package:lab09/components/summary_card.dart';
import 'package:lab09/pages/search.dart';
import 'package:responsive_grid/responsive_grid.dart';


import 'package:lab09/shared/globals.dart' as globals;
import 'package:lab09/shared/colors.dart' as colors;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    List<Widget> summaryCards = [];
    globals.items.forEach((item) {
      summaryCards.add(SummaryCard(item: item, isSeller: false));
    });

    List<ResponsiveGridCol> homePageLayout() {
      List<ResponsiveGridCol> grid = [
        ResponsiveGridCol(
            lg: 12,
            child: Container(
              child: Image.asset(
                'lib/images/app-logo.jpg',
                width: MediaQuery.of(context).size.width,
              ),
            )
        )
      ];

      summaryCards.forEach((sC) {
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
          backgroundColor: colors.grayBlue,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new Search()),
                );
              },
            )
          ],

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
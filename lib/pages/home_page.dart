/*
Home Page - shows header and list of most recent items
 */

import 'package:flutter/material.dart';
import 'package:lab09/components/menu_tabs.dart';
import 'package:lab09/components/summary_card.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'package:lab09/shared/globals.dart' as globals;
import 'package:lab09/shared/colors.dart' as colors;
import 'package:material_search/material_search.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _names =  [
    'Software Engineering',
    'T Shirt',
    'Computer Networking',
  ];

  String _name = 'No one';

  final _formKey = new GlobalKey<FormState>();

  _buildMaterialSearchPage(BuildContext context) {
    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<String>(
              placeholder: 'Enter name of book or cloth',
              results: _names.map((String v) => new MaterialSearchResult<String>(
                icon: Icons.book,
                value: v,
                text: "  $v",
              )).toList(),
              filter: (dynamic value, String criteria) {
                return value.toLowerCase().trim()
                    .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) => Navigator.of(context).pop(value),
              onSubmit: (String value) => Navigator.of(context).pop(value),
            ),
          );
        }
    );
  }

  _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
      setState(() => _name = value as String);
    });
  }


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
                    padding: EdgeInsets.all(15),
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
                showSearch(
                  context: context,
//                delegate: CustomSearchDelegate()
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
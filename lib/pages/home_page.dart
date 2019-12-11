/*
Home Page - shows header and list of most recent items
 */

import 'package:flutter/material.dart';
import 'package:lab09/components/summary_card.dart';
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

    return CustomScrollView(
      slivers: <Widget>[
         SliverAppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
//                      delegate: CustomSearchDelegate()
                );
              },
            ),
          ],
          backgroundColor: colors.grayBlue,
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              globals.appName,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container (
                height: globals.items.length % 2 == 0 ?
                  (globals.items.length ~/ 2).toDouble() * 250 :
                  (globals.items.length ~/ 2).toDouble() * 250 + 250,
                child: GridView.count(
                  childAspectRatio: .8,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: summaryCards,
                )
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
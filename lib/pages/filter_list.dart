import 'package:flutter/material.dart';
import 'package:lab09/components/menu_tabs.dart';
import 'package:lab09/shared/globals.dart' as globals;
import 'package:lab09/shared/colors.dart' as colors;
import 'package:lab09/components/summary_card.dart';
import 'package:responsive_grid/responsive_grid.dart';

class FilterList extends StatefulWidget {
  FilterList({Key key, this.filter}) : super(key: key);

  final String filter;

  @override
  FilterListState createState() => FilterListState();
}

class FilterListState extends State<FilterList> {
  String title = "";

  @override
  Widget build(BuildContext context) {

    List<Widget> summaryCards = [];
    globals.items.forEach((item) {
      if ((this.widget.filter == "Favorited" && globals.user != null && globals.user.favoritedItems.contains(item.reference.documentID)) ||
          (this.widget.filter == "My Items" && globals.user != null && (globals.user.reference.documentID == item.sellerId)) ||
          item.category == this.widget.filter ||
          this.widget.filter == "All Items") {
        summaryCards.add(SummaryCard(item: item, isSeller: this.widget.filter == "My Items"));
      }
    });

    if (this.widget.filter == "Textbook") {
      this.title = "Textbooks";
    } else {
      this.title = this.widget.filter;
    }

    List<ResponsiveGridCol> filterListLayout() {
      List<ResponsiveGridCol> grid = [];

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
          title: Text(this.widget.filter),
          backgroundColor: colors.grayBlue,
        ),
        drawer: MenuTabs(),
        body: SingleChildScrollView(
          child: Container(
              child: ResponsiveGridRow (
                children: filterListLayout(),
              )
          ),
        )
    );
  }
}
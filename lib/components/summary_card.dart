/*
Implements a summary card for an item - used in lists
@params: item, Item: the item to show summarized details about
 */

import 'package:flutter/material.dart';
import 'package:lab09/pages/edit_item.dart';
import 'package:lab09/pages/item_detail.dart';

import 'package:lab09/shared/colors.dart' as colors;
import 'package:lab09/types/item.dart';

import 'favorite_heart.dart';

class SummaryCard extends StatefulWidget {
  SummaryCard({Key key, this.item, this.isSeller}) : super(key: key);

  final Item item;
  final bool isSeller;

  @override
  SummaryCardState createState() => SummaryCardState();
}

class SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
            onTap: () {
              if (!this.widget.isSeller) {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new ItemDetail(item: widget.item)),
                );
              } else {
                Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new ItemForm( item: widget.item )),
                );
              }
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(
                        color: Colors.grey,
                        blurRadius: screenWidth * .03,
                        spreadRadius: screenHeight * .0005
                    )]
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: .025),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding (
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget> [
                            Image.asset(
                              'lib/images/test-img.JPG',
                              height: 75,
                              alignment: Alignment.topCenter,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding (
                                  padding: EdgeInsets.only(bottom: 15),
                                ),
                                Text(
                                  widget.item.name,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 5)
                                ),
                                Row(
                                  children: <Widget>[
                                    widget.item.price != 0 || !widget.item.isOBO ?
                                    Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: colors.lightGreen,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)
                                            )
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Text (
                                            '\$' + widget.item.price.toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                    ) : Container(),
                                    widget.item.price != 0 || !widget.item.isOBO ?
                                    Padding(
                                      padding: EdgeInsets.only(right: 10)
                                    ) : Container(),
                                    widget.item.isOBO ?
                                    Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: colors.teal,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)
                                            )
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Text (
                                            'OBO',
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                    ) : Container()
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: FavoriteHeart(itemId: widget.item.reference.documentID)
                                )
                              ],
                            )
                          ]
                        )
                      )
                    )
                )
            ) // tag container
    );
  }
}
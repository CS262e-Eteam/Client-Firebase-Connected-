/*
Edit Item Page (can also be used to add an item)
 */

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab09/types/item.dart';

import 'package:lab09/shared/colors.dart' as colors;
import 'package:lab09/shared/globals.dart' as globals;

class ItemForm extends StatefulWidget{
  ItemForm({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  State<StatefulWidget> createState(){
    return ItemFormState();
  }
}

class ItemFormState extends State<ItemForm> {
  final itemName = TextEditingController();
  final itemDescription = TextEditingController();
  final itemCost = TextEditingController();
  final itemClass = TextEditingController();
  final itemISBN = TextEditingController();
  final itemSize = TextEditingController();
  final itemBrand = TextEditingController();
  final itemAuthor = TextEditingController();
  bool itemOBO = false;

  FocusNode itemNameNode = new FocusNode();
  FocusNode itemDescriptionNode = new FocusNode();
  FocusNode itemCostNode = new FocusNode();
  FocusNode itemClassNode = new FocusNode();
  FocusNode itemISBNNode = new FocusNode();
  FocusNode itemSizeNode = new FocusNode();
  FocusNode itemBrandNode = new FocusNode();
  FocusNode itemAuthorNode = new FocusNode();

  List<String> conditions = <String>['New', 'Pretty Good', 'Fair', 'Poor'];
  String itemCondition = 'New';

  List<String> itemTypes = <String>['Textbook', 'Clothing', 'Furniture', 'Technology', 'Other'];
  String itemType = 'Textbook';

  List<String> genders = <String>['None', 'Mens', 'Womens', 'Unisex'];
  String itemGender = 'None';

  File imgUrl;

  bool isEdit = false;

  Firestore fDB = Firestore.instance;

  void setImage(var image) async {
    if (image != null) {
      setState(() {
        imgUrl = image;
      });
    }
  }

//  void getCameraImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 360, maxWidth: 360);
//    setImage(image);
//  }

//  void getPhotoGalleryImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 360, maxWidth: 360);
//    setImage(image);
//  }

  Future editImage() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Item Image"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget> [
                  Text("Where do you want to select your image from?"),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget> [
                        FlatButton(
                          child: const Text("LIBRARY"),
                          onPressed: () {
                            Navigator.pop(context);
//                            getPhotoGalleryImage();
                          },
                        ),
                        FlatButton(
                          child: const Text("CAMERA"),
                          onPressed: () {
                            Navigator.pop(context);
//                            getCameraImage();
                          },
                        ),
                      ]
                  ),
                  FlatButton(
                    child: const Text("CANCEL"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )
          );
        }
    );
  }

  void saveItem() {
    fDB.collection('items').document(this.widget.item.reference.documentID).setData({
      'sellerId': this.widget.item.sellerId,
      'price': itemCost.text != '' ? int.parse(itemCost.text) : 0,
      'description': itemDescription.text,
      'isOBO': itemOBO,
      'name': itemName.text,
      'condition': itemCondition,
      'category': itemType,
      'author': itemAuthor.text,
      'course': itemClass.text,
      'iSBN': itemISBN.text,
      'size': itemSize.text,
      'gender': itemGender,
      'brand': itemBrand.text,
      'createdDate': this.widget.item.createdDate
    });

    globals.items = [];
    fDB.collection('items').orderBy('createdDate', descending: true).getDocuments().then((result) {
      result.documents.forEach((snap) {
        globals.items.add(Item.fromSnapshot(snap));
      });

      Navigator.pop(context);
    });
  }

  Future removeItem() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Remove Item"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget> [
                  Text("Are you sure you want to remove this item?"),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget> [
                        FlatButton(
                          child: const Text("CANCEL"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: const Text("OKAY"),
                          onPressed: () {
                            fDB.collection('sold_items').add(this.widget.item.toJson());
                            fDB.collection('sold_items').document(this.widget.item.reference.documentID).setData({
                              'removedDate': Timestamp.now(),
                              'sellerId': this.widget.item.sellerId,
                              'price': itemCost.text != '' ? int.parse(itemCost.text) : 0,
                              'description': itemDescription.text,
                              'isOBO': itemOBO,
                              'name': itemName.text,
                              'condition': itemCondition,
                              'category': itemType,
                              'author': itemAuthor.text,
                              'course': itemClass.text,
                              'iSBN': itemISBN.text,
                              'size': itemSize.text,
                              'gender': itemGender,
                              'brand': itemBrand.text,
                              'createdDate': this.widget.item.createdDate
                            });
                            fDB.collection('items').document(this.widget.item.reference.documentID).delete();

                            globals.items = [];
                            fDB.collection('items').orderBy('createdDate', descending: true).getDocuments().then((result) {
                              result.documents.forEach((snap) {
                                globals.items.add(Item.fromSnapshot(snap));
                              });

                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ]
                  ),
                ],
              )
          );
        }
    );
  }

  List<Widget> optionalFields() {
    List<Widget> optionalFields = [
      imgUrl != null ?
      Image.file(
        imgUrl,
        height: 200,
      ) : Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60),
          child: Text("No Image")
        )
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 15),
      ),
      GestureDetector(
        onTap: () {
          editImage();
        },
        child: Container(
            decoration: BoxDecoration(
              color: colors.lightBerry,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Text(
                imgUrl != null ? "CHANGE IMAGE" : "ADD IMAGE",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
                textAlign: TextAlign.center,
              ),
            )
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 15),
      ),
      TextFormField(
        controller: itemName,
        focusNode: itemNameNode,
        validator: (value) {
          if (value.isEmpty) return "Please enter a name";
          return null;
        },
        keyboardType: TextInputType.text,
        cursorColor: colors.lightBerry,
        decoration: InputDecoration(
          labelText: "Name",
          labelStyle: TextStyle(
              color: itemNameNode.hasFocus ? colors.lightBerry : Colors.black
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colors.lightBerry),
          ),
        ),
      ),
      TextFormField(
        controller: itemDescription,
        focusNode: itemDescriptionNode,
        validator: (value) {
          if (value.isEmpty) return "Please enter a name";
          return null;
        },
        keyboardType: TextInputType.text,
        cursorColor: colors.lightBerry,
        decoration: InputDecoration(
          labelText: "Description",
          labelStyle: TextStyle(
              color: itemDescriptionNode.hasFocus ? colors.lightBerry : Colors.black
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colors.lightBerry),
          ),
        ),
      ),
      Row(
        children: <Widget>[
          Flexible(
              child: TextFormField(
                controller: itemCost,
                focusNode: itemCostNode,
                validator: (value) {
                  if (value.isEmpty) return "Please enter a name";
                  return null;
                },
                keyboardType: TextInputType.number,
                cursorColor: colors.lightBerry,
                decoration: InputDecoration(
                  labelText: "Price",
                  labelStyle: TextStyle(
                      color: itemCostNode.hasFocus ? colors.lightBerry : Colors.black
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colors.lightBerry),
                  ),
                ),
              )
          ),
          Flexible(
              child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                      children: <Widget>[
                        Checkbox(
                            value: itemOBO,
                            activeColor: colors.lightBerry,
                            onChanged: (bool value) {
                              setState(() {
                                itemOBO = value;
                              });
                            }
                        ),
                        Text(
                            "Or Best Offer"
                        )
                      ]
                  )
              )
          )
        ],
      ),
      Row(
        children: <Widget>[
          Flexible(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Condition',
                    labelStyle: TextStyle(
                        color: colors.lightBerry
                    ),
                  ),
                  isEmpty: itemCondition == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: itemCondition,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          itemCondition = newValue;
                          state.didChange(newValue);
                        });
                      },
                      items: conditions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
          ),
          Flexible(
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Type',
                    labelStyle: TextStyle(
                        color: colors.lightBerry
                    ),
                  ),
                  isEmpty: itemType == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: itemType,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          itemType = newValue;
                          state.didChange(newValue);
                        });
                      },
                      items: itemTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),

    ];

    if (itemType == 'Textbook') {
      optionalFields.addAll(
        [
          Padding(
            padding: EdgeInsets.only(bottom: 30),
          ),
          Text(
            "Fields below this point are optional, but will allow others to find your item more easily.",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          TextFormField(
            controller: itemAuthor,
            focusNode: itemAuthorNode,
            validator: (value) {
              if (value.isEmpty) return "Please enter a name";
              return null;
            },
            keyboardType: TextInputType.text,
            cursorColor: colors.lightBerry,
            decoration: InputDecoration(
              labelText: "Author",
              labelStyle: TextStyle(
                  color: itemAuthorNode.hasFocus ? colors.lightBerry : Colors.black
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.lightBerry),
              ),
            ),
          ),
          TextFormField(
            controller: itemClass,
            focusNode: itemClassNode,
            validator: (value) {
              if (value.isEmpty) return "Please enter a name";
              return null;
            },
            keyboardType: TextInputType.text,
            cursorColor: colors.lightBerry,
            decoration: InputDecoration(
              labelText: "Class Used For",
              labelStyle: TextStyle(
                  color: itemClassNode.hasFocus ? colors.lightBerry : Colors.black
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.lightBerry),
              ),
            ),
          ),
          TextFormField(
            controller: itemISBN,
            focusNode: itemISBNNode,
            validator: (value) {
              if (value.isEmpty) return "Please enter a name";
              return null;
            },
            keyboardType: TextInputType.text,
            cursorColor: colors.lightBerry,
            decoration: InputDecoration(
              labelText: "ISBN",
              labelStyle: TextStyle(
                  color: itemISBNNode.hasFocus ? colors.lightBerry : Colors.black
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.lightBerry),
              ),
            ),
          ),
        ]
      );

    } else if (itemType == 'Clothing') {
      optionalFields.addAll(
          [
            Padding(
              padding: EdgeInsets.only(bottom: 30),
            ),
            Text(
              "Fields below this point are optional, but will allow others to find your item more easily.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    controller: itemSize,
                    focusNode: itemSizeNode,
                    validator: (value) {
                      if (value.isEmpty) return "Please enter a name";
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    cursorColor: colors.lightBerry,
                    decoration: InputDecoration(
                      labelText: "Size",
                      labelStyle: TextStyle(
                          color: itemSizeNode.hasFocus ? colors.lightBerry : Colors.black
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colors.lightBerry),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                ),
                Flexible(
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          labelStyle: TextStyle(
                              color: colors.lightBerry
                          ),
                        ),
                        isEmpty: itemGender == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: itemGender,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                itemGender = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: genders.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),

            TextFormField(
              controller: itemBrand,
              focusNode: itemBrandNode,
              validator: (value) {
                if (value.isEmpty) return "Please enter a name";
                return null;
              },
              keyboardType: TextInputType.text,
              cursorColor: colors.lightBerry,
              decoration: InputDecoration(
                labelText: "Brand",
                labelStyle: TextStyle(
                    color: itemBrandNode.hasFocus ? colors.lightBerry : Colors.black
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colors.lightBerry),
                ),
              ),
            ),
          ]
      );
    }

    return optionalFields;
  }

  @override void initState() {
    super.initState();

    if (this.widget.item != null) {
      isEdit = true;

      itemCost.text = this.widget.item.price.toString();
      itemDescription.text = this.widget.item.description;
      itemOBO = this.widget.item.isOBO;
      itemName.text = this.widget.item.name;
      itemCondition = this.widget.item.condition;
      itemType = this.widget.item.category;
      itemAuthor.text = this.widget.item.author;
      itemClass.text = this.widget.item.course;
      itemISBN.text = this.widget.item.iSBN;
      itemSize.text = this.widget.item.size;
      itemGender = this.widget.item.gender;
      itemBrand.text = this.widget.item.brand;
    }
  }

  @override
  Widget build(BuildContext context) {

      return new Scaffold(
          appBar: AppBar(
            title: Text("New Item"),
            backgroundColor: colors.grayBlue,
          ),

          bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.5, color: colors.lightBerry),
                  )
              ),
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: this.isEdit ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors.lightGrayBlue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ),
                      ),
                      GestureDetector(
                        onTap: saveItem,
                        child: Container(
                            decoration: BoxDecoration(
                              color: colors.darkGreen,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                              child: Text(
                                "SAVE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: removeItem,
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors.darkBerry,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                            child: Text(
                              "REMOVE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        )
                      )
                    ],
                  ) : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: colors.lightGrayBlue,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                              child: Text(
                                "CANCEL",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          fDB.collection('items').add(
                              Item(
                                sellerId: globals.user.reference.documentID,
                                price: itemCost.text != '' ? int.parse(itemCost.text) : 0,
                                description: itemDescription.text,
                                isOBO: itemOBO,
                                name: itemName.text,
                                condition: itemCondition,
                                category: itemType,
                                author: itemAuthor.text,
                                course: itemClass.text,
                                iSBN: itemISBN.text,
                                size: itemSize.text,
                                gender: itemGender,
                                brand: itemBrand.text,
                                createdDate: Timestamp.now(),
                              ).toJson()
                          ).then((doc) {
                            Navigator.pop(
                              context,
                            );
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: colors.darkGreen,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                              child: Text(
                                "ADD ITEM",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
              )
          ),
          body: ListView(
            padding: EdgeInsets.all(20),
            children: optionalFields(),
          )
      );
  }
}

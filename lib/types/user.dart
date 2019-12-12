/*
Defines class User
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.reference,
    @required this.username,
    @required this.email,
    @required this.favoritedItems,
    @required this.postedItems,
  });

  final DocumentReference reference;
  final String username;
  final String email;
  final List<String> favoritedItems;
  final List<String> postedItems;

  User.fromMap(Map<String, dynamic> map, {this.reference}) :
    username = map['username'],
    email = map['email'],
    favoritedItems = new List<String>.from(map['favoritedItems']),
    postedItems = new List<String>.from(map['postedItems']);

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {
      'username': username,
      'email': email,
      'favoritedItems': favoritedItems,
      'postedItems': postedItems
    };
  }
}
/*
Defines class User
 */

import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.id,
    @required this.userName,
    @required this.email,
    @required this.favoritedItems,
    @required this.postedItems,
  });

  final String id;
  final String userName;
  final String email;
  final List<String> favoritedItems;
  final List<String> postedItems;
}
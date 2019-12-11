/*
Globals - stores variables that then can be used throughout the app for consistency
 */

import 'package:lab09/types/item.dart';
import 'package:lab09/types/user.dart';

const String appName = "Calvin Marketplace";

bool isLoggedIn = false;

List<Item> items = [];

User testUser = User(
    id: 'DAifJg2BLKlIqHYxt2wk',
    userName: 'testUser',
    email: 'test@test.com',
    favoritedItems: ['tsyhqH27I0qGbN4HTnWA'],
    postedItems: ['tsyhqH27I0qGbN4HTnWA']
  );

//List<Item> testItems = [
//  Item(
//    id: 1,
//    sellerId: 1,
//    price: 25,
//    isOBO: false,
//    name: 'Computer Networking',
//    description: 'This is a useful textbook that you absolutely need',
//    imageURL: '',
//    category: 'Textbook',
//    condition: 'New',
//    iSBN: '123412341234',
//    author: 'John Doe',
//    course: 'CS 342',
//  ),
//  Item(
//    id: 2,
//    sellerId: 1,
//    price: 25,
//    isOBO: true,
//    name: 'Computer Networking',
//    description: 'This is a useful textbook that you absolutely need',
//    imageURL: '',
//    category: 'Textbook',
//    condition: 'New',
//    iSBN: '123412341234',
//    author: 'John Doe',
//    course: 'CS 342',
//  ),
//  Item(
//    id: 3,
//    sellerId: 1,
//    price: 25,
//    isOBO: false,
//    name: 'Software Engineering',
//    description: '',
//    imageURL: '',
//    category: 'Textbook',
//    condition: 'Used',
//    iSBN: '123412341234',
//    author: 'John Doe',
//    course: 'CS 262',
//  ),
//  Item(
//    id: 4,
//    sellerId: 2,
//    price: 10,
//    isOBO: false,
//    name: 'Software Engineering',
//    description: '',
//    imageURL: '',
//    category: 'Textbook',
//    condition: 'New',
//    iSBN: '123412341234',
//    author: 'John Doe',
//    course: 'CS 262',
//  ),
//  Item(
//    id: 5,
//    sellerId: 2,
//    price: 0,
//    isOBO: true,
//    name: 'Software Engineering',
//    description: 'This is an example of a longer textual piece for a description'
//        'that is really interesting because I want to keep getting a lot bigger',
//    imageURL: '',
//    category: 'Textbook',
//    condition: 'Good',
//    iSBN: '123412342222',
//    author: 'James Doe',
//    course: 'CS 262',
//  ),
//  Item(
//    id: 6,
//    sellerId: 3,
//    price: 25,
//    isOBO: false,
//    name: 'Computer Networking',
//    description: 'This is a useful textbook that you absolutely need',
//    imageURL: '',
//    category: 'Textbook',
//    condition: 'Bad',
//    iSBN: '123412341234',
//    author: 'John Doe',
//    course: 'CS 342',
//  ),
//  Item(
//      id: 7,
//      sellerId: 1,
//      price: 5,
//      isOBO: false,
//      name: 'T Shirt',
//      description: '',
//      imageURL: '',
//      category: 'Clothing',
//      condition: 'Bad',
//      size: 'Medium',
//      gender: 'Mens',
//      brand: 'American Eagle'
//  ),
//  Item(
//      id: 8,
//      sellerId: 1,
//      price: 5,
//      isOBO: false,
//      name: 'Black Adidas Shoes',
//      description: '',
//      imageURL: '',
//      category: 'Clothing',
//      condition: 'New',
//      size: '7',
//      gender: 'Mens',
//      brand: 'Adidas'
//  ),
//  Item(
//      id: 9,
//      sellerId: 1,
//      price: 5,
//      isOBO: false,
//      name: 'T Shirt',
//      description: '',
//      imageURL: '',
//      category: 'Clothing',
//      condition: 'Bad',
//      size: 'Medium',
//      gender: 'Mens',
//      brand: 'American Eagle'
//  ),
//  Item(
//      id: 10,
//      sellerId: 1,
//      price: 5,
//      isOBO: false,
//      name: 'Black Adidas Shoes',
//      description: '',
//      imageURL: '',
//      category: 'Clothing',
//      condition: 'Very Good',
//      size: '7',
//      gender: 'Mens',
//      brand: 'Adidas'
//  ),
//  ];


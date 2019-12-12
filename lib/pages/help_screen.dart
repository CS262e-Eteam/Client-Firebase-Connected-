/*
Login Page - allows a user to log in or navigate to sign up page
 */

import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab09/shared/colors.dart' as colors;

class HelpPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
	return HelpScreen();
  }
}

class HelpScreen extends State<HelpPage> {
  final String help_str = """To access the side menu:\n
Check the icon in the upper left corner.\n
1. If it is three horizontal bars, click on it to open the side menu.\n
2. Else, click on the left pointing arrow to go back a screen. Repeat as needed.\n\n
To login:\n
1. Open side menu.\n
2. Click on login\n
3. If you are a returning user\n
\t      a. Fill out email and password\n
\t      b. Click Login\n
\t      c. Then you are logged in and returned to the \n            home screen.\n
4. Otherwise, click on Sign-up\n
5. Fill out username, email, Create Password, and Confirm Password\n
6. Click sign-up\n
To add an item:\n
1. Login\n
2. Open side menu\n
3. Click on “Add Item”\n
4. Fill out information as desired\n
5. Click Add Item to post the item to sell or click Cancel or the back arrow in the upper left to leave page without posting the new item.\n
To Buy an item:\n
1. Find the item you wish to buy\n
2. Click on the item\n
3. Then click on Contact Seller at the bottom of the page.\n
4. Use the contact information to contact the seller (outside the app)\n""";
  @override
  Widget build(BuildContext context) => new Scaffold(
		appBar: AppBar(
			title: Text("Help"),
			backgroundColor: colors.grayBlue,
	  ),
		body: ListView(
			padding: EdgeInsets.all(20),
			children: <Widget>[
				Text(
					"Help",
					style: TextStyle(
						fontSize: 24,
						fontWeight: FontWeight.bold,
					),
				),
				Padding(
					padding: EdgeInsets.only(bottom: 15)
				),
				Padding(
					padding: EdgeInsets.symmetric(horizontal: 10),
					child:Text(help_str,
          textAlign: TextAlign.left,),
				),
				Padding(
					padding: EdgeInsets.only(bottom: 15)
				),
				const SizedBox(height: 30),
				RaisedButton(
					child:Text("Go Back"),
					color: colors.teal,
					onPressed: (){
						Navigator.pop(context);
					}
				),
				Padding(
					padding: EdgeInsets.only(top: 45)
				),
			],
		)
  );
}

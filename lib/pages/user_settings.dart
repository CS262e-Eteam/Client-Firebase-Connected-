/*
User Setting Page - allows a user to edit their details
 */

import 'package:flutter/material.dart';
import 'package:lab09/shared/colors.dart' as colors;
import 'package:lab09/shared/globals.dart' as globals;
import 'package:lab09/pages/filter_list.dart';

class UserSettings extends StatefulWidget{
	@override
	State<StatefulWidget> createState(){
		return UserSettingsState();
	}
}

class UserSettingsState extends State<UserSettings> {
	final usernameEdit = TextEditingController();
	final emailCreate = TextEditingController();
	final emailConfirm = TextEditingController();
	FocusNode usernameEditNode = new FocusNode();
	FocusNode emailCreateNode = new FocusNode();



	@override
	Widget build(BuildContext context) => new Scaffold(
		appBar: AppBar(
			title: Text(globals.testUser.userName),
			backgroundColor: colors.grayBlue,
		),
		body: ListView(
			padding: EdgeInsets.all(20),
			children: <Widget>[
				Text(
					"User Settings",
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
					child: TextFormField(
						initialValue: globals.testUser.userName,
//						controller: usernameEdit,
						focusNode: usernameEditNode,
						validator: (value) {
							if (value.isEmpty) return "Please enter a Username";
							return null;
						},
						keyboardType: TextInputType.text,
						cursorColor: colors.lightBerry,
						decoration: InputDecoration(
							labelText: "Edit Username",
							labelStyle: TextStyle(
								color: usernameEditNode.hasFocus ? colors.lightBerry : Colors.black
							),
							focusedBorder: UnderlineInputBorder(
								borderSide: BorderSide(color: colors.lightBerry),
							),
						),
					),
				),
				Padding(
					padding: EdgeInsets.symmetric(horizontal: 10),
					child: TextFormField(
						initialValue: globals.testUser.email,
//						controller: emailCreate,
						enabled: false,
						focusNode: emailCreateNode,
						validator: (value) {
							if (value.isEmpty) return "Please enter an Email";
							return null;
						},
						keyboardType: TextInputType.text,
						cursorColor: colors.lightBerry,
						decoration: InputDecoration(
							labelText: "User Email",
							labelStyle: TextStyle(
								color: emailCreateNode.hasFocus ? colors.lightBerry : Colors.grey
							),
							focusedBorder: UnderlineInputBorder(
								borderSide: BorderSide(color: colors.lightBerry),
							),
						),
					),
				),

				Padding(
					padding: EdgeInsets.only(bottom: 15)
				),
				Padding(
					padding: EdgeInsets.all(15),
//					child: Container(
//						height: 1,
//						color: colors.lightBerry,
//					)
				),
//				Padding(
//					padding: EdgeInsets.only(bottom: 15)
//				),
//				const SizedBox(height: 30),
				RaisedButton(
					child:Text("Save Changes"),
					color: colors.teal,
					onPressed: (){
						Navigator.pop(context);
						Navigator.pop(context);
					}
				),
				RaisedButton(
					child:Text("My Items"),
					color: colors.teal,
					onPressed: (){
						Navigator.pop(context);
						Navigator.push(
							context,
							new MaterialPageRoute(builder: (context) => new FilterList(filter: "My Items")),
						);
					}
				),
				RaisedButton(
					child:Text("Previous Items"),
					color: colors.teal,
					onPressed: (){
						Navigator.pop(context);
						Navigator.pop(context);
					}
				)
			],
		)
	);
}

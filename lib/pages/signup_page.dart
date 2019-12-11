/*
Sign Up Page - allows a user to create an account
 */

import 'package:flutter/material.dart';
import 'package:lab09/shared/colors.dart' as colors;

class SignUpPage extends StatefulWidget{
	@override
	State<StatefulWidget> createState(){
		return SignUpPageState();
	}
}

class SignUpPageState extends State<SignUpPage> {
	final usernameCreate = TextEditingController();
	final passwordLogin = TextEditingController();
	final emailCreate = TextEditingController();
	final emailConfirm = TextEditingController();
	final passwordCreate = TextEditingController();
	final passwordConfirm = TextEditingController();
	FocusNode usernameCreateNode = new FocusNode();
	FocusNode emailCreateNode = new FocusNode();
	FocusNode passwordCreateNode = new FocusNode();
	FocusNode passwordConfirmNode = new FocusNode();



	@override
	Widget build(BuildContext context) => new Scaffold(
		appBar: AppBar(
			title: Text("Sign Up"),
			backgroundColor: colors.grayBlue,
		),
		body: ListView(
			padding: EdgeInsets.all(20),
			children: <Widget>[
				Text(
					"Get started with a free account",
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
						controller: usernameCreate,
						focusNode: usernameCreateNode,
						validator: (value) {
							if (value.isEmpty) return "Please enter a Username";
							return null;
						},
						keyboardType: TextInputType.text,
						cursorColor: colors.lightBerry,
						decoration: InputDecoration(
							labelText: "Username",
							labelStyle: TextStyle(
								color: usernameCreateNode.hasFocus ? colors.lightBerry : Colors.black
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
						controller: emailCreate,
						focusNode: emailCreateNode,
						validator: (value) {
							if (value.isEmpty) return "Please enter an Email";
							return null;
						},
						keyboardType: TextInputType.text,
						cursorColor: colors.lightBerry,
						decoration: InputDecoration(
							labelText: "Email",
							labelStyle: TextStyle(
								color: emailCreateNode.hasFocus ? colors.lightBerry : Colors.black
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
						controller: passwordCreate,
						focusNode: passwordCreateNode,
						validator: (value) {
							if (value.isEmpty) return "Please enter a Password";
							return null;
						},
						keyboardType: TextInputType.text,
						cursorColor: colors.lightBerry,
						decoration: InputDecoration(
							labelText: "Create Password",
							labelStyle: TextStyle(
								color: passwordCreateNode.hasFocus ? colors.lightBerry : Colors.black
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
						controller: passwordConfirm,
						focusNode: passwordConfirmNode,
						validator: (value) {
							if (value.isEmpty) return "Please enter a Password";
							return null;
						},
						keyboardType: TextInputType.text,
						cursorColor: colors.lightBerry,
						decoration: InputDecoration(
							labelText: "Confirm Password",
							labelStyle: TextStyle(
								color: passwordConfirmNode.hasFocus ? colors.lightBerry : Colors.black
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
					child:Text("Sign Up"),
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


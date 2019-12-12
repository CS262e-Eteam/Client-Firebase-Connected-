/*
Sign Up Page - allows a user to create an account
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lab09/types/user.dart';

import 'package:lab09/shared/colors.dart' as colors;
import 'package:lab09/shared/globals.dart' as globals;

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

	final FirebaseAuth _auth = FirebaseAuth.instance;

	void signUpWithEmail() async {
		FirebaseUser user;

		try {
			if (passwordCreate.text == passwordConfirm.text) {
				AuthResult result = await _auth.createUserWithEmailAndPassword(email: emailCreate.text, password: passwordCreate.text);
				user = result.user;
			}
		} catch (e) {
			print(e.toString());
		} finally {
			if (user != null) {
				print(user);
				Firestore.instance.collection('users').document(user.uid).setData({
					'username': usernameCreate.text,
					'email': emailCreate.text,
					'favoritedItems': [''],
					'postedItems': ['']
				});

				Firestore.instance.collection('users').document(user.uid).get().then((snapshot) {
					if (snapshot != null) {
						globals.user = User.fromSnapshot(snapshot);
					}

					Navigator.pop(context);
					Navigator.pop(context);
				});
			}
		}
	}

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
						obscureText: true,
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
						obscureText: true,
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
						signUpWithEmail();
					}
				)
			],
		)
	);
}


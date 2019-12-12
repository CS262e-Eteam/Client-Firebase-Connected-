/*
Login Page - allows a user to log in or navigate to sign up page
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab09/components/menu_tabs.dart';
import 'package:lab09/shared/colors.dart' as colors;
import 'package:lab09/shared/globals.dart' as globals;
import 'package:lab09/types/user.dart';

import 'signup_page.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
	return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
	String _email, _password;
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailLogin = TextEditingController();
  final passwordLogin = TextEditingController();
//	final itemName = TextEditingController();
	FocusNode emailNode = new FocusNode();
	FocusNode passwordNode = new FocusNode();
//  final emailCreate = TextEditingController();
//  final emailConfirm = TextEditingController();
//  final passwordCreate = TextEditingController();
//  final passwordConfirm = TextEditingController();

	final FirebaseAuth _auth = FirebaseAuth.instance;

	void login() async {
		FirebaseUser user;

		try {
			AuthResult result = await _auth.signInWithEmailAndPassword(email: emailLogin.text, password: passwordLogin.text);
			user = result.user;
		} catch (e) {
			print(e.toString());
		} finally {
			if (user != null) {
				print(user);

				Firestore.instance.collection('users').document(user.uid).get().then((snapshot) {
					if (snapshot != null) {
						globals.user = User.fromSnapshot(snapshot);
					}

					Navigator.pop(context);
				});
			}
		}
	}

  @override
  Widget build(BuildContext context) => new Scaffold(
		appBar: AppBar(
			title: Text("Login"),
			backgroundColor: colors.grayBlue,
	  ),
		drawer: MenuTabs(),
//		body: Form(
//			key: _formKey,
//			child: Column(
//				children: <Widget>[
//					TextFormField(
//						validator: (input) {
//							if(input.isEmpty) {
//								return 'Please enter an email';
//							}
//							return null;
//						} ,
//						onSaved: (input) => _email = input,
//						decoration: InputDecoration(
//							labelText: 'Email'
//						),
//					),
//					TextFormField(
//						validator: (input) {
//							if(input.length < 6) {
//								return 'Your password must be atleast 6 characters';
//							}
//							return null;
//						} ,
//						onSaved: (input) => _password = input,
//						decoration: InputDecoration(
//							labelText: 'Password'
//						),
//						obscureText: true,
//					),
//					RaisedButton(
//						onPressed: () {} ,
//						child: Text('Sign in'),
//					)
//				],
//			),
//		),

		body: ListView(
			padding: EdgeInsets.all(20),
			children: <Widget>[

				Text(
					"Login",
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
						controller: emailLogin,
						focusNode: emailNode,
						validator: (value) {
							if (value.isEmpty) return "Please enter an Email";
							return null;
						},
						keyboardType: TextInputType.text,
						cursorColor: colors.lightBerry,
						decoration: InputDecoration(
							labelText: "Email",
							labelStyle: TextStyle(
								color: emailNode.hasFocus ? colors.lightBerry : Colors.black
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
						controller: passwordLogin,
						focusNode: passwordNode,
						validator: (value) {
							if (value.isEmpty) return "Please enter a Password";
							return null;
						},
						keyboardType: TextInputType.text,
						cursorColor: colors.lightBerry,
						decoration: InputDecoration(
							labelText: "Password",
							labelStyle: TextStyle(
								color: passwordNode.hasFocus ? colors.lightBerry : Colors.black
							),
							focusedBorder: UnderlineInputBorder(
								borderSide: BorderSide(color: colors.lightBerry),
							),
						),
					),
				),
//				Padding(
//					padding: EdgeInsets.symmetric(horizontal: 10),
//					child: Column(
//						crossAxisAlignment: CrossAxisAlignment.start,
//						children: <Widget>[
//							Text(
//								"Email"
//							),
//							TextField(
//								controller: emailLogin,
//							),
//							Padding(
//								padding: EdgeInsets.only(bottom: 15)
//							),
//							Text(
//								"Password"
//							),
//							TextField(
//								controller: passwordLogin,
//							),
//						],
//					)
//				),
				Padding(
					padding: EdgeInsets.only(bottom: 15)
				),

				const SizedBox(height: 30),
				RaisedButton(
					child:Text("Login"),
					color: colors.teal,
					onPressed: (){
						login();
					}
				),
				Padding(
					padding: EdgeInsets.only(top: 45)
				),
				GestureDetector (
					child: Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Text(
								"Don't have an account yet? ",
								textAlign: TextAlign.center,
								style: TextStyle(
									fontSize: 14,
//									color: colors.teal,
								),
							),
							Text(
								"Sign-up",
								textAlign: TextAlign.center,
								style: TextStyle(
									fontSize: 14,
									color: colors.teal,
								),
							)
						],
					),
					onTap: () {
					Navigator.push(
						context,
						new MaterialPageRoute(builder: (context) => new SignUpPage()),
					);
				}
				),
			],
		)
  );

//  Future<void> signIn() async {
//  	final formState = _formKey.currentState;
//  	if(formState.validate()){
//  		formState.save();
//  		try {
//				FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//				Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//			}catch(e){
//  			print(e.message);
//			}
//		}
//	}
}

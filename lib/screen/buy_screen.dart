import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geany/product/product_homepage.dart';

import '../product/product_list.dart';

class BuyerSellerAuthPage extends StatefulWidget {
  @override
  _BuyerSellerAuthPageState createState() => _BuyerSellerAuthPageState();
}

class _BuyerSellerAuthPageState extends State<BuyerSellerAuthPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoginMode = true; // Switch between login and registration mode
  String firstName = '', lastName = '', businessSector = '', gstin = '', email = '', phone = '', password = '';
  bool termsAccepted = false;
  String userType = 'Buyer'; // Default to 'Buyer'

  // Method to toggle between login and register mode
  void toggleAuthMode() {
    setState(() {
      isLoginMode = !isLoginMode;
    });
  }

  // Method to register the user (Buyer or Seller)
  void _registerUser() async {
    if (_formKey.currentState!.validate() && termsAccepted) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password,
        );

        // Save user data in Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'businessSector': businessSector,
          'gstin': gstin,
          'email': email,
          'phone': phone,
          'role': userType,
        });

        Fluttertoast.showToast(msg: 'registered successfully!');
        Navigator.pop(context);
      } catch (e) {
        Fluttertoast.showToast(msg: 'registered Unsuccessful!');

      }
    }
  }

  // Method for login
  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        Fluttertoast.showToast(msg: 'Logged in successfully');
        print('Logged in successfully');
        // Redirect to appropriate page after login
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListPage(),)); // Replace with your main page
      } catch (e) {
        Fluttertoast.showToast(msg: 'Login Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLoginMode ? 'Login Buyer' : 'Register Buyer'),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              if (!isLoginMode) ...[
                TextFormField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) => value!.isEmpty ? 'Enter First Name' : null,
                  onChanged: (value) => firstName = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) => value!.isEmpty ? 'Enter Last Name' : null,
                  onChanged: (value) => lastName = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Business Sector'),
                  validator: (value) => value!.isEmpty ? 'Enter Business Sector' : null,
                  onChanged: (value) => businessSector = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'GSTIN'),
                  validator: (value) => value!.isEmpty ? 'Enter GSTIN' : null,
                  onChanged: (value) => gstin = value,
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) => value!.isEmpty ? 'Enter Phone Number' : null,
                  onChanged: (value) => phone = value,
                ),


              ],
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Enter Email' : null,
                onChanged: (value) => email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password',
                  hintText: 'Enter 6 digit'
                ),

                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Enter Password 6 digit' : null,
                onChanged: (value) => password = value,
              ),
              SizedBox(height: 20),

              CheckboxListTile(
                title: Text("I accept the terms and conditions"),
                value: termsAccepted,
                onChanged: (newValue) {
                  setState(() {
                    termsAccepted = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoginMode ? _loginUser : _registerUser,
                child: Text(isLoginMode ? 'Login ' : 'Register as $userType'),
    style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
    shadowColor: Colors.grey, // Shadow color
    elevation: 5, // Elevation of the button
    shape: RoundedRectangleBorder( // Shape of the button
    borderRadius: BorderRadius.circular(20),
    ),
              ),),
              TextButton(
                onPressed: toggleAuthMode,
                child: Text(isLoginMode
                    ? 'Don\'t have an account? Register here.'
                    : 'Already have an account? Login here.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

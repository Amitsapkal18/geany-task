import 'package:flutter/material.dart';

class SellerHomescreen extends StatefulWidget {
  const SellerHomescreen({super.key});

  @override
  State<SellerHomescreen> createState() => _SellerHomescreenState();
}

class _SellerHomescreenState extends State<SellerHomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome......',style: TextStyle(fontSize: 20),),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geany/screen/buy_screen.dart';
import 'package:geany/screen/seller_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Your onPressed action here
                Navigator.push(context, MaterialPageRoute(builder: (context) => BuyerSellerAuthPage(),));
              },
              child: Text('Buy Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                shadowColor: Colors.grey, // Shadow color
                elevation: 5, // Elevation of the button
                shape: RoundedRectangleBorder( // Shape of the button
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
                textStyle: TextStyle( // Text style
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),


            SizedBox(
              height: 50,
            ),



            ElevatedButton(
              onPressed: () {
                // Your onPressed action here
                Navigator.push(context, MaterialPageRoute(builder: (context) => SellerScreen(),));
              },
              child: Text('Seller Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                shadowColor: Colors.grey, // Shadow color
                elevation: 5, // Elevation of the button
                shape: RoundedRectangleBorder( // Shape of the button
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
                textStyle: TextStyle( // Text style
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),


    );

  }
}

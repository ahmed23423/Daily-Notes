import 'package:flutter/material.dart';

class mainScreen extends StatefulWidget {
  mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const  EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(top: 20, bottom: 20 , left: 20 , right: 20),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.1),
                borderRadius: BorderRadius.circular(1000)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('.. WallPaper', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(.3)),) ,
                  Icon(Icons.search_rounded, size: 30,color: Colors.black.withOpacity(.3),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:firebase_demo/AddProductScreen.dart';
import 'package:firebase_demo/SpecifyDisplay.dart';
import 'package:flutter/material.dart';

import 'DisplayProductScreen.dart';
import 'UploadImage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List _screens = [
    AddProduct(),
    DisplayProduct(),
    SpecifyDisplay(),
    UploadImage()
  ];
  // var documentId;

  //String documentId = "documentId";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView(
            children: [
              Center(
                child: Text("Welcome to home"),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              //icon: Icon(Icons.home),
              icon: Icon(Icons.add),
              label: 'Add Products',
            ),
            BottomNavigationBarItem(
              //icon: Icon(Icons.business),
              icon: Icon(Icons.view_agenda),
              label: 'View Products',
            ),

            BottomNavigationBarItem(
              //icon: Icon(Icons.home),
              icon: Icon(Icons.all_inbox),
              label: 'Specific Products',
            ),

            BottomNavigationBarItem(
              //icon: Icon(Icons.home),
              icon: Icon(Icons.upload),
              label: 'Upload Image',
            ),
            // BottomNavigationBarItem(
            //   //icon: Icon(Icons.school),
            //   icon: IconButton(
            //     onPressed: (){

            //     },
            //     icon: Icon(Icons.school),
            //     ),
            //   label: 'School',
            // ),
          ],
        ));
  }
}


import 'package:flutter/material.dart';
import 'package:tilapia_diseases/Screens/Home_Screen.dart';
import 'package:tilapia_diseases/Screens/Search_Screen.dart';
import 'package:tilapia_diseases/Screens/Upload_Screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex=0;
  List<Widget> listOfScreens= [
    Upload(),
    Search(),
    Home(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",

          ),

        ],
      ),
      body: listOfScreens[currentIndex],
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tilapia_diseases/Register_Screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), AfterPage);
  }
  void AfterPage() async{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Register()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Container(
            height: 300,
            child: Image(image: AssetImage("images/SplashScreenPhoto.jpg"),),
          ),
        ),
      ),
    );
  }
}

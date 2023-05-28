import 'package:flutter/material.dart';
import 'package:tilapia_diseases/DB/hive_db.dart';
import 'package:tilapia_diseases/SplashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveDb.instance.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false; // or true if you want to start in dark mode
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';


class HiveDb {
  HiveDb._privateConstructor();

  static final HiveDb _instance = HiveDb._privateConstructor();

  static HiveDb get instance => _instance;

  late Box box;

  String _key_boxName = 'box';

  Future<void> init()async{
  box = await Hive.openBox(_key_boxName);
  }

  Future<void> storeImageWithText(String label, String imageFilePath) async {
    Map<String , String> dataInMap = {'label' : label,'path' : imageFilePath};
    box.add(dataInMap).then((value) {
      printAllStoredData();
    });
  }

  void printAllStoredData(){
    print('\n\n\n**************** Stored Data ************\n\n');
    box.keys.map((e) => box.get(e)).toList().forEach((element) {print(element['label']);});
  }

}
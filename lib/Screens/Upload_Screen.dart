import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tilapia_diseases/DB/hive_db.dart';
import 'package:tilapia_diseases/Screens/Search_Screen.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  late File _image;
  late List _results;
  bool imageSelect = false;
  final imagepicker = ImagePicker();
  var pickedImage;
  selectImageFromGallery() async {
    pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    } else {}
  }

  selectImageFromCamera() async {
    var getImage = await imagepicker.getImage(source: ImageSource.camera);
    if (getImage != null) {
      setState(() {
        _image = File(getImage.path);
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      print(recognitions!);
      String resultInLabel = recognitions![0]['confidence']>0.5 ? 'This fish may be infected' : 'This fish may be health';
      print(resultInLabel);
      print(_image.path.toString());
      HiveDb.instance.storeImageWithText(resultInLabel, _image.path);
      imageSelect = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Image Classification"),
      // ),

      body: ListView(
        children: [
          SizedBox(
            height: 200,
          ),
          (imageSelect)
              ? Container(
            margin: const EdgeInsets.all(10),
            child: Image.file(_image),
          )
              : Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const Opacity(
                opacity: 0.8,
                child: Center(
                  child: Text(
                    "No image Selected",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),

          // in your eye
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: (imageSelect)
                  ? _results.map((result) {
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  child: Text(
                    "${result['label']} ",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                );
              }).toList()
                  : [],
            ),
          ),
          //زرار
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 50,
            child: ElevatedButton(
              onPressed: pickImage,
              child: Text(
                "Upload FromGallery",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                primary: Color(0xff004494),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Divider
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Container(
                width: 150,
                child: Divider(
                  height: 25,
                  thickness: 2,
                  color: Colors.black26,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Text(
                "OR",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 150,
                child: Divider(
                  height: 25,
                  thickness: 2,
                  color: Colors.black26,
                  indent: 10,
                  endIndent: 10,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 50,
            child: ElevatedButton(
              onPressed: pickCamera,
              child: Text(
                "Upload FromCamera",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                primary: Color(0xff004494),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),

      //   floatingActionButton: FloatingActionButton(
      //     onPressed: pickImage,
      //     tooltip: "Pick Image",
      //     child: const Icon(Icons.image),
      //   ),
    );
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }

  Future pickCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}

//
// class Upload extends StatefulWidget {
//   const Upload({Key? key}) : super(key: key);
//
//   @override
//   State<Upload> createState() => _UploadState();
// }
//
// class _UploadState extends State<Upload> {
//   late List _results;
//   bool imageSelect=false;
//   File? image;
//   final imagepicker = ImagePicker();
//   selectImageFromGallery() async {
//     var pickedImage = await imagepicker.getImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         image = File(pickedImage.path);
//       });
//     } else {}
//   }
//
//   selectImageFromCamera() async {
//     var getImage = await imagepicker.getImage(source: ImageSource.camera);
//     if (getImage != null) {
//       setState(() {
//         image = File(getImage.path);
//       });
//     } else {}
//   }
//
//   ///my code
//
//   void initState()
//   {
//     super.initState();
//     loadModel();
//   }
//   Future loadModel()
//   async {
//     Tflite.close();
//     String res;
//     res=(await Tflite.loadModel(model: "assets/model_unquant.tflite",labels: "assets/labels.txt"))!;
//     print("Models loading status: $res");
//   }
//
//   Future imageClassification(File image)
//   async {
//     final List? recognitions = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 6,
//       threshold: 0.05,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
//     setState(() {
//       _results=recognitions!;
//       image=image;
//       imageSelect=true;
//     });
//   }
//
//
//   @override
//
//   Widget build(BuildContext context) {
//     TextTheme _textTheme = Theme.of(context).textTheme;
//
//     return Scaffold(
//       // backgroundColor: Colors.white,
//
//       // appBar: AppBar(
//       //   title:Text(" Upload Image", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),),
//       //   centerTitle: true,
//       //   backgroundColor: Color(0xff004494),
//       //   elevation: 0,
//       //   leading: IconButton(
//       //     icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white,),
//       //     onPressed: () {
//       //       Navigator.pop(context);
//       //     },
//       //   ),
//       // ),
//       //width: double.infinity, height: double.infinity
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 350,
//               width: 400,
//               margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 // color: Color(0xffD9D9D9),
//               ),
//               child: image == null
//                   ? Center(
//                       child: Text(
//                         "No image Selected",
//                         style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     )
//                   : Container(child: Image.file(image!)),
//             ),
//             SizedBox(height: 50,),
//             ///Lable
//
//             // SingleChildScrollView(
//             //   child: Column(
//             //     children: (imageSelect)?_results.map((result) {
//             //       return Card(
//             //         child: Container(
//             //           margin: EdgeInsets.all(10),
//             //           child: Text(
//             //             "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
//             //             style: const TextStyle(color: Colors.red,
//             //                 fontSize: 20),
//             //           ),
//             //         ),
//             //       );
//             //     }).toList():[],
//             //
//             //   ),
//             // ),
//
//             SizedBox(
//               height: 70,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.7,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: selectImageFromGallery,
//                 child: Text(
//                   "Upload FromGallery",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   primary: Color(0xff004494),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             //Divider
//             Row(
//               children: [
//                 SizedBox(
//                   width: 50,
//                 ),
//                 Container(
//                   width: 150,
//                   child: Divider(
//                     height: 25,
//                     thickness: 2,
//                     color: Colors.black26,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                 ),
//                 Text(
//                   "OR",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: 'Poppins',
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Container(
//                   width: 150,
//                   child: Divider(
//                     height: 25,
//                     thickness: 2,
//                     color: Colors.black26,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.6,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: selectImageFromCamera,
//                 child: Text(
//                   "Upload FromCamera",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   primary: Color(0xff004494),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20,),
//             // Container(
//             //   width: MediaQuery.of(context).size.width * 0.3,
//             //   height: 50,
//             //   child: ElevatedButton(
//             //     onPressed: selectImageFromCamera,
//             //     child: Text(
//             //       "Results",
//             //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             //     ),
//             //     style: ElevatedButton.styleFrom(
//             //       shape: RoundedRectangleBorder(
//             //           borderRadius: BorderRadius.circular(15)),
//             //       primary: Color(0xff004494),
//             //     ),
//             //   ),
//             // ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (BuildContext) {
//                     return Search();
//                   }),
//                 );
//               },
//               child: Text(
//                 "Results ",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//
//               ),
//
//             ),
//           ],
//         ),
//       )),
//     );
//   }
//   Future pickImage()
//   async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     File image=File(pickedFile!.path);
//     imageClassification(image);
//   }
// }
//
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         brightness: Brightness.light,
//         textTheme: TextTheme(
//           headline1: TextStyle(
//             fontSize: 24,
//             color: AppColor.PrimaryColor, // default color for light mode
//           ),
//         ),
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         textTheme: TextTheme(
//           headline1: TextStyle(
//             fontSize: 24,
//             color: Colors.white, // default color for dark mode
//           ),
//         ),
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dark Mode Example'),
//       ),
//       body: Center(
//         child: Text(
//           'Hello, World!',
//           style: Theme.of(context).textTheme.headline1,
//         ),
//       ),
//     );
//   }
// }

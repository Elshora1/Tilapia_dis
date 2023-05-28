import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tilapia_diseases/models/Carousel_Slider.dart';
import 'package:tilapia_diseases/themes/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SliderMode> listOfSlider = [
    SliderMode(image: "images/pii.png"),
    SliderMode(image: "images/pngegg.png"),
    SliderMode(image: "images/pngegg (8).png"),
    SliderMode(image: "images/pngegg (7).png"),
    SliderMode(image: "images/pngegg (3).png"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Text("Home", style: TextStyle(color:Color(0xff223263),fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_outlined, color: Color(0xff223263)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  thickness: 1,
                  color: AppColor.greyColor,
                  endIndent: 5,
                  indent: 5,
                ),
                SizedBox(height: 10,),
                Container(
                  child: CarouselSlider.builder(
                    itemCount: listOfSlider.length,
                    itemBuilder:
                        (BuildContext context, int itemIndex, int pageViewIndex) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(listOfSlider[itemIndex].image),
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                    options: CarouselOptions(
                      height: 220,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      enableInfiniteScroll: true,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "News",
                      style: TextStyle(
                          color: Color(0xff223263),
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "More News",
                        style: TextStyle(
                            color: AppColor.PrimaryColor,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    print("rrrrrrrrrrr");
                  },
                  child: Container(
                    padding: EdgeInsets.all(1),
                     margin: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                    Container(
                      // padding: EdgeInsets.only(left: 10),
                      // margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset("images/pngegg (6).png", width: 190,height: 170,),
                    ),
                    Text("Tilapia\ndiseases\ntreatment",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold , color: Color(0xff223263)),
                    )
                    ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    print("uuuuu");
                  },
                  child: Container(
                    padding: EdgeInsets.all(1),
                    margin: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(left: 10),
                          // margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Image.asset("images/pngegg (2).png", width: 190,height: 170,),
                        ),
                        Text("Tilapia\ndiseases ",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold , color: Color(0xff223263)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          )
      ),
    );
  }
}

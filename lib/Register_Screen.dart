import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tilapia_diseases/Login_Screen.dart';
import 'package:tilapia_diseases/Screens/HomePage_Screen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // please enter your ....
  final _formKey = GlobalKey<FormState>();

  //isObscureText
  bool isObscureText = true;
  bool isObscureTextTwo = true;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordagainController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // color: Colors.red,
            height: 900,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    //image
                    Image.asset(
                      'images/SplashScreenPhoto.jpg',
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Let's Get started
                    Text(
                      "Let's Get started",
                      style: TextStyle(
                        color: Color(0xff223263),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Create an new account
                    Text('Create an new account'),
                    SizedBox(
                      height: 10,
                    ),
                    //Full Name
                    Container(
                      margin: EdgeInsets.all(12),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: fullnameController,
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: Color(0xff9098B1),
                          ),
                        ),
                        //validator
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Email
                    Container(
                      margin: EdgeInsets.all(12),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Your Email',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xff9098B1),
                          ),
                        ),
                        //validator
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          }if(value.length<6){
                            return 'Your email mast be over 6 latters';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Password
                    Container(
                      margin: EdgeInsets.all(12),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: passwordController,
                        obscureText: isObscureText,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xff9098B1),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            },
                            icon: isObscureText
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility), // false
                          ),
                        ),
                        //validator
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Password Again
                    Container(
                      margin: EdgeInsets.all(12),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: passwordagainController,
                        obscureText: isObscureTextTwo,
                        decoration: InputDecoration(
                          hintText: 'Password Again',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xff9098B1),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscureTextTwo = !isObscureTextTwo;
                              });
                            },
                            icon: isObscureTextTwo
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility), // false
                          ),
                        ),
                        //validator
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    // RegisterButton
                    Container(
                      width: 343,
                      height: 57,
                      child: ElevatedButton(
                        onPressed: () {
                          print(fullnameController.text);
                          print(emailController.text);
                          print(passwordController.text);

                          if (_formKey.currentState!.validate()) {
                            if (passwordController.text == passwordagainController.text) {
                              Register();
                              // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              //   return HomePage();
                              // }));
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //   backgroundColor: Colors.green,
                              //       content: Text("Welcome"),
                              // ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("password don't match!!"),
                              ));
                            }
                          }
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff40BFFF),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //have a account?
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "have a account?",
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return Login();
                                      }));
                            },
                            child: Text(
                              "Sign in ",
                              style: TextStyle(
                                color: Color(0xff40BFFF),
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void Register() async {
    try{
      final response =
      await Dio().post("https://api.escuelajs.co/api/v1/users/", data: {
        "name": fullnameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480"
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
        return Login();
      }));
    } on DioError catch (e){
      print("This is an error : ${e.response}");
      if(e.response!.statusCode==400){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("You should enter Valid email and password"),
        ));
      }
    }


  }
}

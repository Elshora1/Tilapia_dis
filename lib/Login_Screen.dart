import 'package:flutter/material.dart';
import 'package:tilapia_diseases/Register_Screen.dart';
import 'package:tilapia_diseases/Screens/HomePage_Screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
// please enter your ....
  final _formKey = GlobalKey<FormState>();

  //isObscureText
  bool isObscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                ),
                Image.asset(
                  'images/fish-logo.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome to lafyuu',
                  style: TextStyle(
                    color: Color(0xff223263),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Sign in continue'),
                SizedBox(
                  height: 5,
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
                      if(value!.length<6){
                        return 'Email must be above 6 character';
                      }
                      if (value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
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
                //Sign In
                Container(
                  width: 343,
                  height: 57,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signIn();
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                          return HomePage();
                        }));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Welcome"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff40BFFF),
                    ),
                  ),
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
                //Login with Google
                SignInButton(
                  Buttons.Google,
                  text: "Login with Google",
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                //Login with Facebook
                SignInButton(
                  Buttons.Facebook,
                  text: "Login with Facebook",
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                //Forget Password
                Text(
                  'Forget Password?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff40BFFF),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Don't have a account
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have a account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff9098B1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return Register();
                                  }));
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff40BFFF),
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
    );
  }
  void signIn() async{
    try{
      final response = await Dio().post("https://api.escuelajs.co/api/v1/auth/login" ,data: {
        "email": emailController.text,
        "password": passwordController.text,
      });
      print("data is : ${response.data['access_token']}");

      final accessToken = response.data['access_token'];

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('access_token', accessToken);

      final access = await prefs.get('access_token');
      print("my access token is : $access");

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      }));
    }
    on DioError catch(e){
      print("This is an Error : ${e.response}");
      if(e.response!.statusCode==401){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("You should enter Valid email and password") ,
          backgroundColor: Colors.red,
        ));
      }
    }

  }
}

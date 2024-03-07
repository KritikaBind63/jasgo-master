import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jasgo/screens/forgot_password_screen.dart';
import 'package:jasgo/screens/signup_num_screen.dart';
import 'package:jasgo/screens/wrapper.dart';
import 'package:jasgo/widget/button_widget.dart';
import 'package:jasgo/widget/navigation_screen.dart';
import 'package:jasgo/widget/textfeild_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'forget.dart';

class LoginScreen extends StatefulWidget {
  final String device;
  LoginScreen({super.key, required this.device});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  bool isActive = false;
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/13,
              ),
              Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    "assets/images/jasgo_logo.png",width: 400,)),
              SizedBox(
                height: 20,
              ),
              Text(
                'Log-in',
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Color(0xff121826)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Welcome to Jasgo App',
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: const Color(0xff535353)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                  controller: phoneController,
                  obscureText: false,
                  inputType: TextInputType.text,
                  text: 'Phone Number',
                  hintText: "Enter Phone Number",
                  cursorColor:  Color(0xff2972FF),
                  inputAction: TextInputAction.next,
                  Maxline: 1),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  controller: passwordController,
                  obscureText: false,
                  inputType: TextInputType.text,
                  text: 'Password',
                  hintText: "Enter Password",
                  cursorColor:  Color(0xff2972FF),
                  inputAction: TextInputAction.next,
                  Maxline: 1),
              SizedBox(
                height:50,
              ),
              GestureDetector(
                onTap: () {

                  if (phoneController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    loginApi();
                  }

                },
                child: ButtonWidget(
                    text: "Login",
                    color: Color(0xff2972FF),
                    textColor: Colors.white,
                    width: double.infinity),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                          text: " ",
                          style: GoogleFonts.lato(
                            color: const Color(0xff000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                                text: "Forgot Password ?",
                                style: GoogleFonts.lato(
                                  color: const Color(0xfff58220),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage()));


                                  }),
                          ]),
                    ),
                  ),


                ],
              ),

              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                      text: "Don’t have account ? ",
                      style: GoogleFonts.lato(
                        color: const Color(0xff000000),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: "Sign Up",
                            style: GoogleFonts.lato(
                              color: const Color(0xfff58220),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GetMaterialApp(
                                home: SignNumScreen(device: 'device'),)));


                              }),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

 Future<void>loginApi()async{
    showDialog(context: context, builder: (context){
      return Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
          strokeWidth: 1.5,
        ),
      );
    });

    var response = await http.post(
        Uri.parse(
        "https://jasgo.in/api/Login.php"
        ),
      headers: {
      "Accept": "application/json"
      },
      body: {
      "Username": phoneController.text,
        "Password": passwordController.text
      });

    if(response.statusCode == 200) {
     print(response.body);
      Navigator.of(context).pop();
      final data = json.decode(response.body);
      if (data["success"] == true) {
        Navigator.of(context).pop();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setInt("user_id", data["user"]["Id"]);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => NavigationScreen(
                  device: 'device',
                )),
                (route) => false);
      }
      else{
        dialogBox(data['message']);
      }
    }
    else{
      Navigator.of(context).pop();
      final data = json.decode(response.body);
      dialogBox(data['message']);
    }

  }

  dialogBox(String msg) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: AlertDialog(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Text('Error', style: GoogleFonts.roboto()),
              content: Text(msg, style: GoogleFonts.roboto()),
              actions: <Widget>[
                TextButton(
                  child: Text('OK', style: GoogleFonts.roboto()),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
          );
        });
  }

}

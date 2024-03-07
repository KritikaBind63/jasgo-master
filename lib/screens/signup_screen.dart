import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jasgo/screens/login_screen.dart';
import 'package:jasgo/widget/button_widget.dart';
import 'package:jasgo/widget/textfeild_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  final String device;
  const SignUpScreen({super.key, required this.device});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        leadingWidth: 35,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        title: Text("",
            style: GoogleFonts.roboto(
              color: Color(0xff000000),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Sign-Up',
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
                height: 50,
              ),
              TextFieldWidget(
                  controller: nameController,
                  obscureText: false,
                  inputType: TextInputType.text,
                  text: 'Name',
                  hintText: "Enter Name",
                  cursorColor: Color(0xff2972FF),
                  inputAction: TextInputAction.next,
                  Maxline: 1),
              SizedBox(
                height: 20,
              ),
              Text("Phone Number",
                  style: GoogleFonts.roboto(
                    color: const Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: TextField(
                  cursorColor: const Color(0xff2C2939),
                  obscureText: false,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    border: InputBorder.none,
                    hintText: "Phone Number",
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  controller: passwordController,
                  obscureText: false,
                  inputType: TextInputType.text,
                  text: 'Password',
                  hintText: "Enter Password",
                  cursorColor: Color(0xff2972FF),
                  inputAction: TextInputAction.next,
                  Maxline: 1),
              SizedBox(
                height: 20,
              ),
              Text("Date of Birth",
                  style: GoogleFonts.roboto(
                    color: const Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    border: InputBorder.none,

                    //  prefixIcon: Icon(Icons.phone),

                    hintText: 'Date',
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB7B8B8)),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                      DateFormat("dd-MM-yyyy").format(pickedDate);
                      setState(() {
                        dateController.text = formattedDate.toString();
                      });
                    } else {
                      print("Not Selected");
                    }
                  },
                  readOnly: true,
                ),
              ),

              SizedBox(
                height: 150,
              ),
              GestureDetector(
                onTap: (){
                  if (phoneController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    singupApi();
                  }
                },
                child: ButtonWidget(text: "Sign Up",
                    color: Color(0xff2972FF),
                    textColor: Colors.white,
                    width: double.infinity),
              )
            ],
          ),
        ),
      ),

    );
  }
Future<void>singupApi()async{
    showDialog(context: context, builder: (context){
      return Center(
       child: CircularProgressIndicator(
         color: Colors.blue,
         strokeWidth: 1.5,
       ), 
      );
    });
    var response = await http.post(
      Uri.parse("https://jasgo.in/api/signup.php"),
      headers: {
        "Accept" : "appication/json"
      },
      body: {
        "Name": nameController.text,
        "Username": phoneController.text,
        "Password" : passwordController.text,
        "Birthday" : dateController.text,
      });

    if(response.statusCode == 200){
      print(response.body);
      Navigator.of(context).pop();
      final data = json.decode(response.body);
      if(data["success"]== true){
        Navigator.of(context).pop();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setInt("data", data["data"]["Id"]);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => LoginScreen(
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

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jasgo/screens/login_screen.dart';
import 'package:jasgo/widget/button_widget.dart';
import 'package:jasgo/widget/textfeild_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CreateForgotScreen extends StatefulWidget {



  @override
  State<CreateForgotScreen> createState() => _CreateForgotScreenState();
}

class _CreateForgotScreenState extends State<CreateForgotScreen> {

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var confirmPass;

  bool _passwordsMatch = true;
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
              SizedBox(height: 10),
              Text(
                'Create Password',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: Color(0xff121826),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to Jasgo App',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: const Color(0xff535353),
                ),
              ),
              SizedBox(height: 50),
          // TextFormField(
          //   validator: (value) {
          //     confirmPass = value;
          //     if (value!.isEmpty) {
          //       return "Please Enter New Password";
          //     } else if (value.length < 8) {
          //       return "Password must be atleast 8 characters long";
          //     } else {
          //       return null;
          //     }
          //   },
          //   decoration: InputDecoration(
          //     hintText: "Enter New Password",
          //     hintStyle: TextStyle(color: Colors.grey),
          //     border: new OutlineInputBorder(
          //       borderRadius: const BorderRadius.all(
          //         const Radius.circular(40.0),
          //       ),
          //     ),
          //   ),
          // ),

        SizedBox(height: 20),
        // Container(
        //   child: TextFormField(
        //     validator: (value) {
        //       if (value!.isEmpty) {
        //         return "Please Re-Enter New Password";
        //       } else if (value.length < 8) {
        //         return "Password must be atleast 8 characters long";
        //       } else if (value != confirmPass) {
        //         return "Password must be same as above";
        //       } else {
        //         return null;
        //       }
        //     },
        //     decoration: InputDecoration(
        //       hintText: "Re-Enter New Password",
        //       hintStyle: TextStyle(color: Colors.grey),
        //       border: new OutlineInputBorder(
        //         borderRadius: const BorderRadius.all(
        //           const Radius.circular(40.0),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter New Password',
                  //errorText: !_passwordsMatch ? 'Passwords do not match' : null,
                ),
              ),
        //       SizedBox(height: 20),
        //       TextField(
        //         controller: _confirmPasswordController,
        //         obscureText: true,
        //         decoration: InputDecoration(
        //           labelText: 'Confirm Password',
        //           hintText: 'Enter Confirm Password',
        //           errorText: !_passwordsMatch ? 'Passwords do not match' : null,
        //         ),
        //       ),
              SizedBox(height: MediaQuery.of(context).size.height / 2.5),
              // GestureDetector(
              //   onTap: () {
              //     if (_passwordController.text == _confirmPasswordController.text) {
              //       // Passwords match, you can proceed
              //       // Add your code to handle password submission here
              //       print("true");
              //       print("...........................");
              //     } else {
              //       // Passwords do not match
              //       setState(() {
              //         _passwordsMatch = false;
              //       });
              //     }
              //   },
              //   child: ElevatedButton(
              //     onPressed: () {
              //       //loginApi();
              //
              //     },
              //     child: Text('Submit'),
              //     style: ElevatedButton.styleFrom(
              //       primary: Color(0xff2972FF),
              //       onPrimary: Colors.white,
              //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //     ),
              //   ),
              // ),
              ElevatedButton(
                onPressed: loginApi,
                child: Text('Submit'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) return Colors.green;
                      return Colors.greenAccent;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
  String getSanitizedPhoneNumber(String phoneNumber) {
    // Remove all non-numeric characters from the phone number
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    var n=pref.getString("PhoneNumber");




    var response = await http.post(
        Uri.parse(
            "https://jasgo.in/api/update_pass.php"
        ),

        headers: {
          "Accept": "application/json"
        },

        body: {
          "Username": n,
          "New-Password":_passwordController.text,
        });



    if(response.statusCode == 200) {
      print(response.body);
     // Navigator.of(context).pop();
      final data = json.decode(response.body);
      if (data["error"] == "200") {
        dialogBox(data['message']);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(device: '',)));


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

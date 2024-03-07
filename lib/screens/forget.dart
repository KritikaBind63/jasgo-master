import 'dart:convert';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'create_forgot_password.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  String _verificationId = "";

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String error = "";

  Future<void> _resetPassword() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91${_phoneNumberController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          // If verification is completed automatically, sign in with the credential
          // and the password reset link will be sent to the user's mobile number.
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification Failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {

            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        timeout: Duration(seconds: 120), // Timeout for OTP verification
      );
    } catch (e) {
      print("Error occurred: $e");
    }
  }
  // Future<void> _resetPassword() async {
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: '+91${_phoneNumberController.text}',
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await _auth.signInWithCredential(credential);
  //         // If verification is completed automatically, sign in with the credential
  //         // and the password reset link will be sent to the user's mobile number.
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print("Verification Failed: ${e.message}");
  //         if (e.code == 'invalid-phone-number') {
  //           print("not found");
  //           print("..............................");
  //           // Handle the case where the phone number is not registered
  //           showDialog(
  //             context: context,
  //             builder: (context) {
  //               return AlertDialog(
  //                 title: Text('Error'),
  //                 content: Text('This phone number is not registered.'),
  //                 actions: [
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Text('OK'),
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         }
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         setState(() {
  //           _verificationId = verificationId;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         setState(() {
  //           _verificationId = verificationId;
  //         });
  //       },
  //       timeout: Duration(seconds: 120), // Timeout for OTP verification
  //     );
  //   } catch (e) {
  //     print("Error occurred: $e");
  //   }
  // }


  Future<void> _confirmOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );
      await _auth.signInWithCredential(credential);
      // If OTP is confirmed, sign in with the credential and reset the password.
     // await _auth.sendPasswordResetRequest(_auth.currentUser!.phoneNumber!);
      // Password reset link will be sent to the user's mobile number.
      print("Password reset link sent successfully.");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateForgotScreen()));
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IntlPhoneField(
              controller: _phoneNumberController,
              flagsButtonPadding: const EdgeInsets.all(8),
              dropdownIconPosition: IconPosition.trailing,
              decoration: const InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

                labelText: 'Phone Number',
                labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color:  Color(0xffB7B8B8)
                ),
                //                 // border: OutlineInputBorder(
                //                 //   borderSide: BorderSide(),
                // ),
              ),
              initialCountryCode: 'IN',

              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),

            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: loginApi,
              child: Text('Reset Password'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) return Colors.green;
                    return Colors.greenAccent;
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Visibility(
              visible: _verificationId.isNotEmpty,
              child: Column(
                children: [
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(labelText: 'OTP'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _confirmOTP,
                    child: Text('Confirm OTP'),
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
          ],
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
            "https://jasgo.in/api/user_exist.php"
        ),
        headers: {
          "Accept": "application/json"
        },
        body: {
          "Username": _phoneNumberController.text,

        });

    if(response.statusCode == 200) {
      print(response.body);
      Navigator.of(context).pop();
      final data = json.decode(response.body);
      if (data["message"] == "User already exists") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("PhoneNumber", _phoneNumberController.text);

setState(() {
  _resetPassword();
});
  print("..........................");

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

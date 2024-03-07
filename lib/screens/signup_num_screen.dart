

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:jasgo/screens/otp_second_screen.dart';
import 'package:jasgo/widget/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'forget.dart';

class SignNumScreen extends StatefulWidget {
  final String device;
  const SignNumScreen({super.key,required this.device});

  @override
  State<SignNumScreen> createState() => _SignNumScreenState();
}

class _SignNumScreenState extends State<SignNumScreen> {

  final TextEditingController phonenumber = TextEditingController();
  sendcode() async{
    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber:'+91'+phonenumber.text ,


          verificationCompleted: (PhoneAuthCredential credential){},

          verificationFailed: (FirebaseAuthException e){
            Get.snackbar('Error Occured 1', e.code);
          },

          codeSent: (String vid , int? token){
            Get.to(OPTSecondScreen(vid:vid,phonenumber: phonenumber.text,),);
          },
           codeAutoRetrievalTimeout: (vid){}
      );
    }on FirebaseAuthException catch(e){
      Get.snackbar('Error Occured 2', e.code);
    }
    catch(e)
    {
      Get.snackbar('Error Occured 3', e.toString());
    }
  }
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
          'Sign Up with Number',
          style: GoogleFonts.inter(
              color: const Color(0xff1E293B),
              fontSize: 24,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Welcome to Jasgo App',
          style: GoogleFonts.inter(
              color: const Color(0xff64748B),
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
              SizedBox(
                height: 50,
              ),
              Text("Enter Number",
                  style: GoogleFonts.roboto(
                    color: const Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 10,
              ),
              IntlPhoneField(
                controller: phonenumber,
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
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN',

                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),

              SizedBox(
                  height: MediaQuery.of(context).size.height/2
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       alignment: Alignment.center,
              //       child: Text.rich(
              //         TextSpan(
              //             text: " ",
              //             style: GoogleFonts.lato(
              //               color: const Color(0xff000000),
              //               fontSize: 15,
              //               fontWeight: FontWeight.w500,
              //             ),
              //             children: [
              //               TextSpan(
              //                   text: "Forgot Password ?",
              //                   style: GoogleFonts.lato(
              //                     color: const Color(0xfff58220),
              //                     fontSize: 15,
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //                   recognizer: TapGestureRecognizer()
              //                     ..onTap = () {
              //                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage()));
              //
              //
              //                     }),
              //             ]),
              //       ),
              //     ),
              //
              //
              //   ],
              // ),
              GestureDetector(
                onTap: (){

                  sendcode();
                },
                child: ButtonWidget(

                    text: "Verify",
                    color:  Color(0xff2972FF) ,
                    textColor: Colors.white,
                    width: double.infinity),
              )



            ],
          ),
        ),
      ),

    );
  }

}


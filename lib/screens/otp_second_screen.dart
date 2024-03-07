import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jasgo/screens/signup_screen.dart';
import 'package:jasgo/widget/button_widget.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';

class OPTSecondScreen extends StatefulWidget {
  final String vid;
 final  String phonenumber;


  const OPTSecondScreen({super.key, required this.vid, required this.phonenumber});

  @override
  State<OPTSecondScreen> createState() => _OPTSecondScreenState();
}

class _OPTSecondScreenState extends State<OPTSecondScreen> {
  var code='';
  signIn() async{
    PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: widget.vid, smsCode:code);
    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((value){
      Get.offAll( SignUpScreen(device: '',));
      });
    } on FirebaseAuthException catch(e){
      Get.snackbar('Error 1', e.code);
    }
    catch(e){
      Get.snackbar('Error 2', e.toString());
    }
  }
  var OTP = "";
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;
  void _resendCode() {
    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        leadingWidth: 50,
        leading: Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Color(0xff2C2939),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Verification Code',
                  style: GoogleFonts.inter(
                      color: const Color(0xff1E293B),
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'We have sent the code verification to',
                  style: GoogleFonts.inter(
                      color: const Color(0xff64748B),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  widget.phonenumber,
                  style: GoogleFonts.inter(
                      color: const Color(0xff64748B),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 40,
                ),
                textcode(),
                // OTPTextField(
                //     length: 4,
                //     width: MediaQuery.of(context).size.width,
                //     fieldWidth: 70,
                //     style: GoogleFonts.inter(
                //         color: const Color(0xff626262),
                //         fontSize: 15,
                //         fontWeight: FontWeight.w500),
                //     textFieldAlignment: MainAxisAlignment.spaceAround,
                //     fieldStyle: FieldStyle.box,
                //     onCompleted: (pin) {
                //       setState(() {
                //         OTP = pin.toString();
                //       });
                //     }),
                SizedBox(
                  height: 35,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                        text: "Didn't receive any code? ",
                        style: GoogleFonts.roboto(
                          color: const Color(0xff000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                              text: "Resend New Code",
                              style: GoogleFonts.roboto(
                                color: const Color(0xfff58220),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  /* Navigator.push(context,
                                   MaterialPageRoute(
                                       builder: (context) {
                                         return const SignInScreen();
                                       }));
                             }*/
                                }),
                        ]),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height/2
                ),
                GestureDetector(
                  onTap: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen(device: 'device')));
                 signIn();
                  },
                  child: ButtonWidget(
                      text: "Verify",
                      color: Color(0xff2972FF),
                      textColor: Colors.white,
                      width: double.infinity),
                ),

              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget textcode()
  {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Pinput(
          length:6,
          onChanged: (value){
            setState(() {
              code=value;
            });
          },

        ),
      ),
    );
  }
}

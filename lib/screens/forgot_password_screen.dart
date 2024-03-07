import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jasgo/screens/otp_screen.dart';
import 'package:jasgo/widget/button_widget.dart';

class ForgotScreen extends StatefulWidget {
  final String device;
  const ForgotScreen({super.key, required this.device});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController forgotController = TextEditingController();

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
                'Forgot Password',
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

                flagsButtonPadding: const EdgeInsets.all(8),
                dropdownIconPosition: IconPosition.trailing,

                decoration: const InputDecoration(

                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
               //   border: InputBorder.none,
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
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(device: 'device',Mobile:' ')));
                },
                child: ButtonWidget(

                    text: "Send OTP",
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

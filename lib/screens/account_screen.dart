import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jasgo/profile/all_post_screen.dart';
import 'package:jasgo/profile/edit_profile.dart';
import 'package:jasgo/screens/login_screen.dart';
import 'package:jasgo/widget/profile_container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  final String device;
  const AccountScreen({super.key, required this.device});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool light0 = true;
  bool light1 = true;
  bool isActive = false;
  var _isUploading;
  void initState() {
    super.initState();
    // loadUserId();
  }

  // Future<void> loadUserId() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isUploading = preferences.getBool("_isUploading");
  //   });
  // }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
                color: Color(0xff6d6eab),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Row(children: [
              CircleAvatar(
                radius: 31.5,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/free-photo/half-profile-image-handsome-young-caucasian-man-with-good-skin-brown-eyes-black-stylish-hair-stubble-posing-isolated-against-blank-wall-looking-front-him-smiling_343059-4560.jpg"),
                  radius: 30,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rihan Saifi",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Text("Edit Profile",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>EditProfile(device: 'device')));
                            },
                          ),
                        ],
                      )
                    ]),
              )
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          // if (_isUploading)
          //   LinearProgressIndicator(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AllPostScreen()));
            },
            child: ContainerWidget(text: 'All Post', color: Colors.black),
          ),
          GestureDetector(
            onTap: () {},
            child: ContainerWidget(text: 'Profile Share', color: Colors.black),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        " Push Notification",
                        style: GoogleFonts.roboto(
                          color: Color(0xff121826),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Transform.scale(
                    scale: 0.90,
                    child: Switch(
                        value: light0,
                        onChanged: (bool value) {
                          setState(() {
                            light0 = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        " Video Autoplay",
                        style: GoogleFonts.roboto(
                          color: Color(0xff121826),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Transform.scale(
                    scale: 0.90,
                    child: Switch(
                        value: light1,
                        onChanged: (bool value) {
                          setState(() {
                            light1 = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child:
                ContainerWidget(text: 'Terms & Condition', color: Colors.black),
          ),
          GestureDetector(
            onTap: () {},
            child: ContainerWidget(text: 'Privacy Policy', color: Colors.black),
          ),
          GestureDetector(
            onTap: () {},
            child: ContainerWidget(text: 'Help & Support', color: Colors.black),
          ),
          GestureDetector(
            onTap: () {},
            child: ContainerWidget(text: 'About', color: Colors.black),
          ),

          GestureDetector(
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              print(pref.getInt("user_id"));
              pref.remove("user_id");
              print("............................................");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                return LoginScreen(device: '');
              }));
            },

            child: ContainerWidget(text: 'Logout', color: Colors.red),
          ),
        ],
      )),
    );
  }
}

class Global {
  static final shared = Global();
  bool isInstructionView = false;
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jasgo/more_button_screen/upload_image.dart';
import 'package:jasgo/more_button_screen/upload_reel.dart';
import 'package:jasgo/more_button_screen/upload_video.dart';
import 'package:jasgo/screens/account_screen.dart';
import 'package:jasgo/screens/create_video_screen.dart';
import 'package:jasgo/screens/home_screen.dart';
import 'package:jasgo/screens/more_screen.dart';
import 'package:jasgo/screens/reels_screen.dart';



class NavigationScreen extends StatefulWidget {
  final String device;
  const NavigationScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(
        device: 'Android',
        text: '',
        url: ''),
    ReelsScreen(
        device: 'Android',
    ),
    CreateVideoScreen(
        device: 'Android'
    ),
    AccountScreen(
        device: 'Android'
    ),

  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen
    (device: 'device', text: '', url: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: PageStorage(

          bucket: bucket,
          child: currentScreen,
      ),
     floatingActionButton: FloatingActionButton(
       backgroundColor: Colors.white,
       child: Icon(Icons.add),
       onPressed: (){
         showModalBottomSheet(
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.only(
                   topRight: Radius.circular(25),
                   topLeft: Radius.circular(25),
                 )),
             context: context,
             builder: (BuildContext bc) {
               return StatefulBuilder(builder:
                   (BuildContext context, StateSetter setState) {
                 return BackdropFilter(
                     filter:
                     ImageFilter.blur(
                         sigmaX: 0.3, sigmaY: 0.3),
                     child: Container(
                       padding: EdgeInsets.all(20),
                       child: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             GestureDetector(
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context)=>UploadImage()));
                               },
                               child: Row(
                                 children: [
                                   Image.asset(
                                     "assets/icons/user_icon.png.png",
                                     width: 25,
                                     color: Colors.black54,
                                   ),
                                   SizedBox(
                                     width: 20,
                                   ),
                                   Text(
                                     "Upload Image",
                                     style: GoogleFonts.dmSans(
                                       textStyle: const TextStyle(
                                         color: Colors.black54,
                                         fontSize: 16,
                                         fontWeight: FontWeight.w500,
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               height: 20,
                             ),
                             GestureDetector(
                               onTap: ()  {
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context)=>ReelScreen()));
                               },
                               child: Row(
                                 children: [
                                   Image.asset(
                                     "assets/icons/user_icon.png.png",
                                     width: 25,
                                     color: Colors.black54,
                                   ),
                                   const SizedBox(
                                     width: 20,
                                   ),
                                   Text(
                                     "Upload Reel",
                                     style: GoogleFonts.dmSans(
                                       textStyle: const TextStyle(
                                         color: Colors.black54,
                                         fontSize: 16,
                                         fontWeight: FontWeight.w500,
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(
                               height: 20,
                             ),
                             GestureDetector(
                               onTap: ()  {
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context)=>VideoScreen()));

                               },
                               child: Row(children: [
                                 Image.asset(
                                   "assets/icons/user_icon.png.png",
                                   width: 25,
                                   color: Colors.black54,
                                 ),
                                 const SizedBox(
                                   width: 20,
                                 ),
                                 Text(
                                   "Upload Video",
                                   style: GoogleFonts.dmSans(
                                     textStyle: const TextStyle(
                                       color: Colors.black54,
                                       fontSize: 16,
                                       fontWeight: FontWeight.w500,
                                     ),
                                   ),
                                 )
                               ]),
                             ),
                             const SizedBox(
                               height: 15,
                             ),
                           ]),
                     ));
               });
             });
       },

       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
bottomNavigationBar: BottomAppBar(
  color: Colors.white,
  shape: CircularNotchedRectangle(),
  notchMargin: 10,
  child: Container(
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:<Widget> [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              minWidth: 40,
              onPressed: (){
                setState(() {
                  currentScreen = HomeScreen(
                      device: '', text: '', url: '');
                  currentTab = 0;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                      AssetImage(
                    "assets/icons/Home.png",),
                    color: currentTab == 0 ? Colors.blue : Colors.grey,
                    size: 23,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                        color: currentTab == 0 ? Colors.blue : Colors.grey
                    ),
                  )
                ],
              ),
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: (){
                setState(() {
                  currentScreen = ReelsScreen(
                      device: '',);
                  currentTab = 1;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage(
                      "assets/icons/reels.png",),
                    color: currentTab == 1 ? Colors.blue : Colors.grey,
                    size: 23,
                  ),

                  Text(
                    "Reel",
                    style: TextStyle(
                        color: currentTab == 1 ? Colors.blue : Colors.grey
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        // Right Tab Bar Icons
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              minWidth: 40,
              onPressed: (){
                setState(() {
                  currentScreen = CreateVideoScreen(
                      device: '', );
                  currentTab = 3;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage(
                      "assets/icons/video.png",),
                    color: currentTab == 3 ? Colors.blue : Colors.grey,
                    size: 23,
                  ),
                  Text(
                    "Video",
                    style: TextStyle(
                        color: currentTab == 3 ? Colors.blue : Colors.grey
                    ),
                  )
                ],
              ),
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: (){
                setState(() {
                  currentScreen = AccountScreen(
                    device: '',);
                  currentTab = 4;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage(
                      "assets/icons/user.png",),
                    color: currentTab == 4 ? Colors.blue : Colors.grey,
                    size: 23,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                        color: currentTab == 4 ? Colors.blue : Colors.grey
                    ),
                  )
                ],
              ),
            )
          ],
        )


      ],
    ),
  ),
),
    );
  }
}






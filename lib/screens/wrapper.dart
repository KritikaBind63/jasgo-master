import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jasgo/screens/signup_num_screen.dart';

import 'home_screen.dart';

class Wrapper extends StatefulWidget{
  State<Wrapper> createState()=>_WrapperState();
}
class _WrapperState extends State<Wrapper>
{
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          GetMaterialApp(
            home: SignNumScreen(device: 'device'),
          );
          if(!snapshot.hasData)
            {
              return  HomeScreen(
                  device: 'Android',
                  text: '',
                  url: '');
            }
          else
            {
              return GetMaterialApp(
                home: SignNumScreen(device: 'device'),
              );

            }


        }
      ),
    );
  }
}
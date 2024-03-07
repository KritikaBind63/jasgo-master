import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jasgo/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  TextEditingController TitleController=new TextEditingController();
  File? uploadimage;
  ImagePicker picker = ImagePicker();
  bool showSpinner = false;


  Future<void> uploadInfo() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getInt("user");
    print(userId);
    // ignore: unrelated_type_equality_checks
    if ( TitleController.text.isNotEmpty &&

        uploadimage != null) {
      // setState(() {
      //   isLoading = true;
      // });

      var request = http.MultipartRequest('POST', Uri.parse(
          "https://jasgo.in/api/image.php"));


      request.fields['User_id'] = userId.toString();
      request.fields["Title"] = TitleController.text;
      request.fields["Likes"] = 0.toString();
      request.fields["Views"] = 0.toString();

      request.files.add(await http.MultipartFile.fromPath('Image', uploadimage!.path));
      var res = await request.send();

      var responseData = await res.stream.transform(utf8.decoder).join();
      Map<String, dynamic> responseJson = jsonDecode(responseData);

      // Check the success field in the response
      if (responseJson.containsKey('success') && responseJson['success'] == false) {
        // Failed to upload file
        print("Failed to upload file: ${responseJson['message']}");
      }


      if (res.statusCode == 200) {
        setState(() {
          TitleController.clear();

          uploadimage = null;
        });
        print("Upload Image .................................");


        // ignore: avoid_print
        print(res);
      }
      else {
        setState(() {
          print("Sorry ............ some input are incorrect");
          print(res.statusCode);
          // isLoading = false;
          // showModalBox("Error", "Data is not Submitted Successfully", context);
        });
      }
    }
    else {
      setState(() {
        print("error");

        // showModalBox("Error", "Please Filled All Field Properly", context);
        // isLoading = false;
      });
    }
  }


  Future getImage(ImageSource media) async {
    final img = await picker.pickImage(source: media,
        imageQuality: 80);

    if(img!= null){
      uploadimage = File(img.path);
      setState(() {

      });
    }else{
      print('no image selected');

    }

  }


//show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);

                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Upload Image",
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
        backgroundColor: Color(0xff6d6eab),
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        elevation: 0,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: TitleController,
                decoration: InputDecoration(

                  hintText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  myAlert();
                },
                child: Text('Choose Photo'),
              ),
              SizedBox(
                height: 10,
              ),

              //if image not null show the image
              //if image null show text
              uploadimage != null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    //to show image, you type like this.
                    File(uploadimage!.path),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ),
              )
                  : Text(
                "No Image",
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: () {
                  uploadInfo();
                  //uploadImageApi();

                },
                child: Text('Upload'),
              ),
            ],
          ),
        ),
      ),

    );
  }




}

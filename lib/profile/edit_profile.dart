import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jasgo/widget/button_widget.dart';
import 'package:jasgo/widget/textfeild_prefixicon_widget.dart';

class EditProfile extends StatefulWidget {
  final String device;
  const EditProfile({super.key, required this.device});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  File? imageFile;
  @override
  void initState() {
    super.initState();
    //profileApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                              )),
                              context: context,
                              builder: (BuildContext bc) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 0.3, sigmaY: 0.3),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
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
                                                      "View Photo",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  await _getCamera();
                                                  if (imageFile != null) {}
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
                                                      "Take Photo",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  await _getGallery();
                                                  if (imageFile != null) {
                                                    //UpdateApi();
                                                  }
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
                                                    "Select from gallery",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                        child: Stack(clipBehavior: Clip.none, children: [
                          (imageFile == null)
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 51,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/icons/photo-camera.png"),
                                    backgroundColor: Colors.grey.shade200,
                                    radius: 50,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 50,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade200,
                                    radius: 50,
                                    backgroundImage: FileImage(
                                      imageFile!,
                                    ),
                                  ),
                                ),
                        ]),
                      ),
                    ],
                  ),
                  Text(
                    "Change profile photo",
                    style: GoogleFonts.roboto(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFeildPrefixWidget(
                  controller: mailController,
                  obscureText: false,
                  inputType: TextInputType.text,
                  text: "",
                  hintText: "User Email ",
                  cursorColor: Color(0xff2972FF),
                  inputAction: TextInputAction.next,
                  Maxline: 1,
                  prefixIcon: ("assets/icons/mail.png")),
              TextFeildPrefixWidget(
                  controller: nameController,
                  obscureText: false,
                  inputType: TextInputType.text,
                  text: "",
                  hintText: "User Name",
                  cursorColor: Color(0xff2972FF),
                  inputAction: TextInputAction.next,
                  Maxline: 1,
                  prefixIcon: ("assets/icons/user_icon.png.png")),
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
                          color: Color(0xffB7B8B8)),
                      prefixIcon: Image.asset(
                        "assets/icons/phone_icon.png",
                        scale: 24,
                      )),
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
                      hintText: 'Date',
                      hintStyle: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffB7B8B8)),
                      prefixIcon: Image.asset(
                        "assets/icons/calendar.png",
                        scale: 24,
                      )),
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
                height: MediaQuery.of(context).size.height / 3,
              ),
              GestureDetector(
                onTap: () {},
                child: ButtonWidget(
                    text: "Update",
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

  _getGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      File? img = File(pickedFile.path);
      setState(() {
        imageFile = img;
      });
    }
  }

  _getCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      File? img = File(pickedFile.path);
      setState(() {
        imageFile = img;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  bool isActive = false;
  List NotificationList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Notification",
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
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(
              height: 5,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/icons/profile.png",
                      width: 25,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    " Your Account Has Been Registered successfully!",
                  //  NotificationList[index]["notification"],
                    style: GoogleFonts.dmSans(
                      color: const Color(0xff000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    "24-02-2024",
                   /* DateFormat('dd MMM y - h:mm a').format(
                        DateTime.parse(
                            NotificationList[index]["created_at"])),*/
                    style: GoogleFonts.dmSans(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.black45,
                  indent: 15,
                  endIndent: 15,
                );
              },
            ),
          ],
        ),
      )
    );
  }
}

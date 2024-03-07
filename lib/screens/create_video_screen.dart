import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import '../module/ViewVideo.dart';

class CreateVideoScreen extends StatefulWidget {
  final String device;
  const CreateVideoScreen({super.key, required this.device});

  @override
  State<CreateVideoScreen> createState() => _CreateVideoScreenState();
}
enum SampleItem { itemOne, itemTwo, itemThree }
class _CreateVideoScreenState extends State<CreateVideoScreen> {
  List<ViewVideo> k=[];
  var video_details;
  // void initState() {
  //   getData();
  //   super.initState();
  //
  // }

  Future<void> getData() async {
    var data = {
      "class": "",
    };

// Starting App API Call.
    var response = await http.post(
        Uri.parse(
            "https://bananacoders.000webhostapp.com/uploadVideoView.php"),
        body: json.encode(data))
        .catchError((e) {
      if (e is SocketException) print("No internet connection");
      setState(() {

      });
    });
// Getting Server response into variable.
    var obj = jsonDecode(response.body);

    if (obj["status"] == "success") {
      setState(() {
        print(".....................................................");
        print(obj["videos"]);
        video_details = obj["videos"];
        for (int x = 0; x < video_details.length; x++) {
          // print("Hello:::: ${product_details[x]["prod_name"]}");
          // print("Hello:::: ${product_details[x]["product_image"]}");

          k.add(ViewVideo(
              video_details[x]["id"], video_details[x]["name"],
              video_details[x]["VideoPath"]));
        }
        print(k.length);
      });
    } else {
      setState(() {

      });
    }
  }
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  SampleItem? selectedItem;

  final List<String> _ids = [
    /*'nPt8bK2gbaU',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',*/
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override
  void initState() {
    getData();
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
   _idController = TextEditingController();
    _seekToController = TextEditingController();
     _videoMetaData =  YoutubeMetaData();
     _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 3,
                /*_ids.length,*/
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _text("title", _videoMetaData.title),
                            SizedBox(
                              height: 10,
                            ),
                            // YoutubePlayerBuilder(
                            //     player: YoutubePlayer(
                            //       controller: _controller,
                            //       showVideoProgressIndicator: true,
                            //       progressIndicatorColor: Colors.blue,
                            //       topActions: [
                            //         const SizedBox(width: 8.0),
                            //         Expanded(
                            //           child: Text(
                            //             _controller.metadata.title,
                            //             style: const TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 18.0,
                            //             ),
                            //             overflow: TextOverflow.ellipsis,
                            //             maxLines: 1,
                            //           ),
                            //         ),
                            //         IconButton(
                            //           onPressed: () {
                            //             log('Settings Tapped!');
                            //           },
                            //           icon: Icon(
                            //             Icons.settings,
                            //             color: Colors.white,
                            //             size: 25.0,
                            //           ),
                            //         )
                            //       ],
                            //       onReady: () {
                            //         _isPlayerReady = true;
                            //       },
                            //       onEnded: (data) {
                            //         _controller.load(_ids[
                            //         (_ids.indexOf(data.videoId) + 1) %
                            //             _ids.length]);
                            //         _showSnackBar('Next Video Started!');
                            //       },
                            //     ),
                            //     builder: (context, player) {
                            //       return Column(
                            //         children: [player],
                            //       );
                            //     }),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "https://img.freepik.com/free-photo/half-profile-image-handsome-young-caucasian-man-with-good-skin-brown-eyes-black-stylish-hair-stubble-posing-isolated-against-blank-wall-looking-front-him-smiling_343059-4560.jpg"),
                                          radius: 20,
                                        ),
                                        onTap: () {
                                        },
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        child: _text(
                                            "Channel", _videoMetaData.author),
                                        /*Text(
                                          "Jasgo Digital Pvt Ltd",
                                          style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),*/
                                        onTap: () {

                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      PopupMenuButton<SampleItem>(
                                          initialValue: selectedItem,
                                          onSelected:
                                              (SampleItem item) {
                                            setState(() {
                                              selectedItem = item;
                                            });
                                          },
                                          itemBuilder: (BuildContext
                                          context) =>
                                          <PopupMenuEntry<
                                              SampleItem>>[
                                            PopupMenuItem<
                                                SampleItem>(
                                              value: SampleItem
                                                  .itemOne,
                                              child: Text("Edit"),
                                            ),
                                            PopupMenuItem<
                                                SampleItem>(
                                              value: SampleItem
                                                  .itemTwo,
                                              child: Text("Delete"),
                                            ),
                                            /* PopupMenuItem<SampleItem>(
                                                  value: SampleItem.itemThree,
                                                  child: Text("Item 3"),
                                                ),*/
                                          ])


                                    ],
                                  ),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Profile Name.",
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                Text(
                                  "1k views",
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                Text(
                                  "1 month ago",
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/like.png",
                                      width: 22,
                                    ),
                                    Text(
                                      "1K",
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/dislike.png",
                                      width: 22,
                                    ),
                                    Text(
                                      "100K",
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/share.png",
                                      width: 22,
                                    ),
                                    Text(
                                      "Share",
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/comment.png",
                                      width: 22,
                                    ),
                                    Text(
                                      "Comments",
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ]));
                }),
            SizedBox(
              height: 70,
            ),


          ],
        ),
      ) ,
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '',
        style: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
        children: [
          TextSpan(
            text: value,
            style: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
          ),
        ],
      ),
    );
  }


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
  }


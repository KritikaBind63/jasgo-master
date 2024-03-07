import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jasgo/screens/more_screen.dart';
import 'package:jasgo/screens/notification_screen.dart';
import 'package:jasgo/screens/user_profile_details.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String url;
  final String text;
  final String device;
  const HomeScreen(
      {super.key, required this.device, required this.text, required this.url});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List _photo = [
    Data(image: "assets/images/image(1).jpg", text: ''),
    Data(image: "assets/images/image(2).jpg", text: ''),
    Data(image: "assets/images/image(3).jpg", text: ''),
    Data(image: "assets/images/image(4).jpg", text: ''),
    Data(image: "assets/images/image(5).jpg", text: ''),
  ];
  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final TextEditingController searchController = TextEditingController();
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;

  bool _isPlayerReady = false;
  final List<String> _ids = [
    'nPt8bK2gbaU',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ'
        '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override
  void initState() {
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
      //initialVideoId: "https://www.youtube.com/watch?v=5PwjvgbBMsk&list=RD5PwjvgbBMsk&start_radio=1&ab_channel=Chandan",
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = YoutubeMetaData();
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "assets/images/jasgo_logo.png",
              fit: BoxFit.contain,
              height: 30,
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width / 1.5,
            //height: MediaQuery.of(context).size.height/5,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: TextField(
              controller: searchController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: InputBorder.none,
                //  prefixIcon: Icon(Icons.phone),
                hintText: 'search...',
                hintStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffB7B8B8)),
              ),
              style: GoogleFonts.roboto(
                color: Color(0xff858585),
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
            child: Container(
              width: 22,
              child: Image.asset("assets/icons/notification.png"),
            ),
          )
        ]),
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 1,
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
                            YoutubePlayerBuilder(
                                player: YoutubePlayer(
                                  controller: _controller,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.blue,
                                  topActions: [
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        _controller.metadata.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        log('Settings Tapped!');
                                      },
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                                    )
                                  ],
                                  onReady: () {
                                    _isPlayerReady = true;
                                  },
                                  onEnded: (data) {
                                    _controller.load(_ids[
                                        (_ids.indexOf(data.videoId) + 1) %
                                            _ids.length]);
                                    _showSnackBar('Next Video Started!');
                                  },
                                ),
                                builder: (context, player) {
                                  return Column(
                                    children: [player],
                                  );
                                }),
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileDetails()));
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileDetails()));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          // height: 40,
                                          // width: 130,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade300,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Text(
                                            'Follow',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    GestureDetector(
                                      child: Image.asset(
                                        "assets/icons/comment.png",
                                        width: 22,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MoreScreen(
                                                        device: 'device')));
                                      },
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
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 1,
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
                            YoutubePlayerBuilder(
                                player: YoutubePlayer(
                                  controller: _controller,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.blue,
                                  topActions: [
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        _controller.metadata.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        log('Settings Tapped!');
                                      },
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                                    )
                                  ],
                                  onReady: () {
                                    _isPlayerReady = true;
                                  },
                                  onEnded: (data) {
                                    _controller.load(_ids[
                                        (_ids.indexOf(data.videoId) + 1) %
                                            _ids.length]);
                                    _showSnackBar('Next Video Started!');
                                  },
                                ),
                                builder: (context, player) {
                                  return Column(
                                    children: [player],
                                  );
                                }),
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileDetails()));
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileDetails()));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          // height: 40,
                                          // width: 130,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade300,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Text(
                                            'Follow',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    GestureDetector(
                                      child: Image.asset(
                                        "assets/icons/comment.png",
                                        width: 22,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MoreScreen(
                                                        device: 'device')));
                                      },
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
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 1,
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
                            Container(
                              width: double.infinity,
                              height: 230,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(
                                    _photo[index].image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileDetails()));
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileDetails()));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          // height: 40,
                                          // width: 130,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade300,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Text(
                                            'Follow',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    GestureDetector(
                                      child: Image.asset(
                                        "assets/icons/comment.png",
                                        width: 22,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MoreScreen(
                                                        device: 'device')));
                                      },
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
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 1,
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
                            Container(
                              width: double.infinity,
                              height: 230,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/image(2).jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileDetails()));
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileDetails()));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          // height: 40,
                                          // width: 130,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade300,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Text(
                                            'Follow',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    GestureDetector(
                                      child: Image.asset(
                                        "assets/icons/share.png",
                                        width: 22,
                                      ),
                                      onTap: () {},
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
                                    GestureDetector(
                                      child: Image.asset(
                                        "assets/icons/comment.png",
                                        width: 22,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MoreScreen(
                                                        device: 'device')));
                                      },
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
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        AssetImage("assets/icons/reels.png"),
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Reels",style: GoogleFonts.roboto(
                          fontSize: 15,color: Colors.black,fontWeight:FontWeight.w500 ),),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Platform.isAndroid ? Icons.more_vert : Icons.more_horiz),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.60,
              child: GestureDetector(
                onTap: () {},
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) => Card(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2.60,
                          width: MediaQuery.of(context).size.height / 3.5,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(17.0)),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/image_listview.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
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
}

class Data {
  String image;
  String text;

  Data({
    required this.image,
    required this.text,
  });
}

class VideoItem {
  final String image;
  final String name;

  VideoItem(this.image, this.name);
}

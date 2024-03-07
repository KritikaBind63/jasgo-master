import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jasgo/profile/all_post_image_screen.dart';
import 'package:jasgo/screens/user_profile_details.dart';
import 'package:reels_viewer/reels_viewer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AllPostScreen extends StatefulWidget {
  const AllPostScreen({super.key});

  @override
  State<AllPostScreen> createState() => _AllPostScreenState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _AllPostScreenState extends State<AllPostScreen> {
  final List _photo = [
    Data(image: "assets/images/image(1).jpg", text: ''),
    Data(image: "assets/images/image(2).jpg", text: ''),
    Data(image: "assets/images/image(3).jpg", text: ''),
    Data(image: "assets/images/image(4).jpg", text: ''),
    Data(image: "assets/images/image(5).jpg", text: ''),
    Data(image: "assets/images/image(1).jpg", text: ''),
    Data(image: "assets/images/image(2).jpg", text: ''),
    Data(image: "assets/images/image(3).jpg", text: ''),
    Data(image: "assets/images/image(4).jpg", text: ''),
    Data(image: "assets/images/image(5).jpg", text: ''),
    Data(image: "assets/images/image(1).jpg", text: ''),
    Data(image: "assets/images/image(2).jpg", text: ''),
    Data(image: "assets/images/image(3).jpg", text: ''),
  ];
  final List _video = [
    Video(image: "assets/images/image(1).jpg", text: ""),
    Video(image: "assets/images/image(2).jpg", text: ""),
    Video(image: "assets/images/image(3).jpg", text: ""),
    Video(image: "assets/images/image(4).jpg", text: ""),
  ];
  SampleItem? selectedItem;
  List<ReelModel> reelsList = [
    ReelModel(
        'https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4',
        'Darshan Patil',
        likeCount: 2000,
        isLiked: true,
        musicName: 'In the name of Love',
        reelDescription: "Life is better when you're laughing.",
        profileUrl:
            'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
        commentList: [
          ReelCommentModel(
            comment: 'Nice...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
          ReelCommentModel(
            comment: 'Superr...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
          ReelCommentModel(
            comment: 'Great...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
        ]),
    ReelModel(
      'https://assets.mixkit.co/videos/preview/mixkit-father-and-his-little-daughter-eating-marshmallows-in-nature-39765-large.mp4',
      'Rahul',
      musicName: 'In the name of Love',
      reelDescription: "Life is better when you're laughing.",
      profileUrl:
          'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
    ),
    ReelModel(
      'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
      'Rahul',
    ),
  ];
  final TextEditingController searchController = TextEditingController();
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
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
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(

            bottom: TabBar(
              dividerColor: Colors.transparent,
              indicatorWeight: 2,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text(
                    "Image",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),

                  ),
                ),
                Tab(
                  child: Text(
                    "Reel",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                Tab(
                  child: Text(
                    "Video",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            title: Text("All Post",
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
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
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
                                    Text("Hello"),
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
                                              "assets/images/image(2).jpg"),
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
                                                child: Text(
                                                  "Jasgo Digital Pvt Ltd",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
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

                                              /*GestureDetector(
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
                                              ),*/
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
                                    Text("Hello"),
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
                                              "assets/images/image(1).jpg"),
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
                                                child: Text(
                                                  "Jasgo Digital Pvt Ltd",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
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

                                              /*GestureDetector(
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
                                              ),*/
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
                                    Text("Hello"),
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
                                              "assets/images/image(4).jpg"),
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
                                                child: Text(
                                                  "Jasgo Digital Pvt Ltd",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
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

                                              /*GestureDetector(
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
                                              ),*/
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
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.20,
                      child: ReelsViewer(
                        reelsList: reelsList,
                        appbarTitle: '',
                        onShare: (url) {
                          log('Shared reel url ==> $url');
                        },
                        onLike: (url) {
                          log('Liked reel url ==> $url');
                        },
                        onFollow: () {
                          log('======> Clicked on follow <======');
                        },
                        onComment: (comment) {
                          log('Comment on reel ==> $comment');
                        },
                        onClickMoreBtn: () {
                          log('======> Clicked on more option <======');
                        },
                        onClickBackArrow: () {
                          log('======> Clicked on back arrow <======');
                        },
                        onIndexChanged: (index) {
                          log('======> Current Index ======> $index <========');
                        },
                        showProgressIndicator: true,
                        showVerifiedTick: true,
                        showAppbar: false,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
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


                  ],
                ),
              )
            ],
          ),
        ));
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

class PhotoItem {
  final String image;
  final String name;

  PhotoItem(this.image, this.name);
}

final List<PhotoItem> _items = [
  PhotoItem(
      "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "Hello Rihan Saifi"),
  PhotoItem(
      "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "Hello Jasgo"),
  PhotoItem(
      "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "Hello Rihan Saifi"),
  PhotoItem(
      "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "Hello Jasgo"),
  PhotoItem(
      "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "Hello Rihan Saifi"),
  PhotoItem(
      "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "Hello Jasgo"),
  PhotoItem(
      "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "Hello Rihan Saifi"),
  PhotoItem(
      "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "Hello Jasgo"),
];

class Data {
  String image;
  String text;

  Data({
    required this.image,
    required this.text,
  });
}

class Video {
  String image;
  String text;
  Video({required this.image, required this.text});
}

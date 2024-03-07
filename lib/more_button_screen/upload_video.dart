import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../screens/home_screen.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  File? _video;
  bool _isPlaying = false;
  bool _isUploading = false; //  this variable for progressbar

  @override
  VideoPlayerController? _videoPlayerController;
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: true,
    );

    if (result != null) {
      setState(() {
        _video = File(result.files.single.path!);
        _videoPlayerController = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }
  Future<void> uploadVideo() async {
    //SharedPreferences preferences = SharedPreferences.getInstance() as SharedPreferences;
    // preferences.setBool("_isUploading",_isUploading  );
    setState(() {
      _isUploading = true; // Show the progress bar
    });
    SharedPreferences preferences = SharedPreferences.getInstance() as SharedPreferences;
    var userId = preferences.getInt("user_id");
    print(userId);
    if (Title.text.isNotEmpty && _video != null)
    {
      var request = http.MultipartRequest('POST', Uri.parse(
          "https://jasgo.in/api/video.php"));

      request.fields['User_id'] = userId.toString();
      request.fields["Title"] = Title.text;
      request.fields["Description"] = Discription.text;
      request.fields["Likes"] = 0.toString();
      request.fields["Views"] = 0.toString();

      request.files.add(
          await http.MultipartFile.fromPath('Videos', _video!.path));
      var response = await request.send();

      var responseData = await response.stream.transform(utf8.decoder).join();
      HomeScreen(
          device: 'Android',
          text: '',
          url: '');
      Map<String, dynamic>responseJson = jsonDecode(responseData);

      if (responseJson.containsKey('success') &&
          responseJson['success'] == false) {
        print("Failed to upload file : ${responseJson['message']}");
      }

      if (response.statusCode == 200) {
        print("hello.............................");
        // Navigator.pushReplacementNamed(context, MaterialPageRoute(builder: (context)=>  HomeScreen(
        //     device: 'Android',
        //     text: '',
        //     url: ''),) as String);
        setState(() {
          Title.clear();
          Discription.clear();
          _video = null;
          _videoPlayerController=null;
        });
        print("Upload Video .................................");


        // ignore: avoid_print
        print(response);
      }
      else {
        setState(() {
          print("Sorry ............ some input are incorrect");
          print(response.statusCode);
          // isLoading = false;
          // showModalBox("Error", "Data is not Submitted Successfully", context);
        });
      }
    }
    else{

      setState(() {
        print("error");
      });
    }
    setState(() {
      print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
      _isUploading = false; // Hide the progress bar
    });
  }

  TextEditingController Title=new TextEditingController();
  TextEditingController Discription=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Video",
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
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: Title,
                decoration: InputDecoration(

                  hintText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  //  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,

                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: Discription,
                decoration: InputDecoration(

                  hintText: "Discription",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  // fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                ),
              ),
              ElevatedButton(
                onPressed:_pickVideo,
                child: Text('Select Video'),
              ),
              SizedBox(height: 20.0),
              _videoPlayerController != null
                  ? AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_videoPlayerController!),
                    VideoProgressIndicator(
                      _videoPlayerController!,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.blue,
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    _isPlaying
                        ? SizedBox()
                        : IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        setState(() {
                          _videoPlayerController!.play();
                          _isPlaying = true;
                        });
                      },
                    ),
                  ],
                ),
              )
                  : SizedBox(),
              SizedBox(height: 20.0),
              ElevatedButton(
               // onPressed: _isUploading ? null : uploadVideo,
                onPressed:uploadVideo,
                child: Text('Upload Video'),
              ),
              // if (_isUploading)
              //   LinearProgressIndicator(),// Show progress indicator if uploading
              // SizedBox(
              //   height: 20,
              //   child: CircularProgressIndicator(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

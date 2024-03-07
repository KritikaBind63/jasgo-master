import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:video_player/video_player.dart';

class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key});

  @override
  State<ReelScreen> createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {

  TextEditingController Title=new TextEditingController();
  File? _reelVideo;
  VideoPlayerController? _videoPlayerController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }
  Future<void> uploalReels() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getInt("user_id");
    print(userId);
    if (Title.text.isNotEmpty &&  _reelVideo!= null)
    {
      var request = http.MultipartRequest('POST', Uri.parse(
          "https://jasgo.in/api/reels.php"));

      request.fields['User_id'] = userId.toString();
      request.fields["Title"] = Title.text;

      request.fields["Likes"] = 0.toString();
      request.fields["Views"] = 0.toString();

      request.files.add(
          await http.MultipartFile.fromPath('Reels',_reelVideo!.path));
      var response = await request.send();

      var responseData = await response.stream.transform(utf8.decoder).join();
      Map<String, dynamic>responseJson = jsonDecode(responseData);

      if (responseJson.containsKey('success') &&
          responseJson['success'] == false) {
        print("Failed to upload file : ${responseJson['message']}");
      }

      if (response.statusCode == 200) {
        setState(() {
          Title.clear();

          _reelVideo = null;
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Reel",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: Title,
                decoration: InputDecoration(

                  hintText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  // fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,

                ),
              ),
              ElevatedButton(
                onPressed: _pickReelVideo,
                child: Text('Select Reel Video'),
              ),
              SizedBox(height: 20.0),
              _reelVideo != null
                  ? AspectRatio(
                aspectRatio: 15/ 20,
                //       aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_videoPlayerController!),
                    IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_isPlaying) {
                            _videoPlayerController?.pause();
                          } else {
                            _videoPlayerController?.play();
                          }
                          _isPlaying = !_isPlaying;
                        });
                      },
                    ),
                  ],
                ),
              )
                  : SizedBox(),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: uploalReels,
                child: Text('Upload Reel Video'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _pickReelVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: true,
    );

    if (result != null) {
      setState(() {
        _reelVideo = File(result.files.single.path!);
        _videoPlayerController = VideoPlayerController.file(_reelVideo!)
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

}

import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:dranchalsclass/sarvice.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Singlevideo extends StatefulWidget {
  const Singlevideo({Key? key,@required this.id}) : super(key: key);
final id;




  @override
  State<Singlevideo> createState() => _SinglevideoState();
}

class _SinglevideoState extends State<Singlevideo> {

  Serves serves=Serves();
int check=1;
   late VideoPlayerController _videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
    Timer(Duration(seconds: 2), () => checksesiion());
  }
  checksesiion(){
    setState(() {

    });
  }


  Future<void> initializeVideoPlayer() async {

    _videoPlayerController = VideoPlayerController.network(
        serves.url+widget.id);
    await Future.wait([

      _videoPlayerController.initialize()
    ]);
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    setState(() {
      check=0;
    });

  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(''),
        backgroundColor: Color(0xAABF21D9),
      ),
      body: SafeArea(
        child:Container(
          child: Center(
            child:check ==0 &&
                chewieController.videoPlayerController.value.isInitialized
                ? Chewie(
              controller: chewieController,
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading'),
              ],
            ),
          ),
        )
      ),


    );
  }
}

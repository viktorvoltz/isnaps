import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key key,
    @required this.videoFile,
  }) : super(key: key);

  final Future<File> videoFile;

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  bool initialized = false;

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initVideo() async {
    final video = await widget.videoFile;
    _controller = VideoPlayerController.file(video)
      ..setLooping(true)
      ..initialize().then((_) => setState(() => initialized = true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initialized ? Scaffold(
        body: Center(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),),),

            floatingActionButton: FloatingActionButton(
              onPressed: (){
                setState(() {
                  if(_controller.value.isPlaying){
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },

              child:  Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            ),
      ):
      Center(child: CircularProgressIndicator()),
    );
  }
}

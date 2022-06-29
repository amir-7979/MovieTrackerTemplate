import 'package:app04/utilities/consts.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewiePlayer extends StatefulWidget {
  final String url;

  ChewiePlayer(this.url);

  @override
  State<StatefulWidget> createState() {
    return _ChewiePlayerState();
  }
}

class _ChewiePlayerState extends State<ChewiePlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.url);
    await Future.wait([
      _videoPlayerController.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      aspectRatio: 5/3,
      progressIndicatorDelay: bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      hideControlsTimer: const Duration(seconds: 1),
      // Try playing around with some of these other options:
      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      /*placeholder: Container(
         color: Colors.grey,
       ),*/
      // autoInitialize: true,
    );

  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: screenWidth,
      height: screenWidth *3/5,
      child: Center(
        child: _chewieController != null &&
                _chewieController!
                    .videoPlayerController.value.isInitialized
            ? ClipRRect(
          borderRadius: BorderRadius.circular(10),
              child: Chewie(
                  controller: _chewieController!,
                ),
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
    );
  }
}

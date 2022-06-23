import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class TrailerPartWidget extends StatefulWidget {
  late final String? trailerUrl;

  TrailerPartWidget(this.trailerUrl);

  @override
  State<TrailerPartWidget> createState() => _TrailerPartWidgetState();
}

class _TrailerPartWidgetState extends State<TrailerPartWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.trailerUrl!)..initialize();
    _controller.setLooping(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          VideoPlayer(_controller),
          IconButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
          Positioned(
            right: -0.1,
            top: -0.1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () {
                  _controller.dispose();
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.red,
                  child: const Icon(Icons.close,
                      color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoContent extends StatefulWidget {
  final String path;
  final String thumbnailPath;
  final bool isNetwork;
  const VideoContent(
      {Key? key,
      required this.path,
      required this.thumbnailPath,
      this.isNetwork = true})
      : super(key: key);

  @override
  State<VideoContent> createState() => _VideoContentState();
}

class _VideoContentState extends State<VideoContent> {
  late VideoPlayerController _controller;
  Future<void>? _initializeVideoPlayerFuture;
  bool _showThumbnail = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.isNetwork
        ? VideoPlayerController.network(
            widget.path,
          )
        : VideoPlayerController.asset(
            widget.path,
          );
  }

  void loadVideo() {
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _renderThumbnail() {
    return InkWell(
        onTap: () {
          setState(() {
            _showThumbnail = false;
            loadVideo();
          });
        },
        child: Image.asset(widget.thumbnailPath));
  }

  void _togglePlayStopVideo() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showThumbnail
        ? _renderThumbnail()
        : FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showThumbnail = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            primary: Colors.red,
                            onPrimary: Colors.red,
                          ),
                          child: Icon(Icons.close)),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: _togglePlayStopVideo,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            primary: CustomTheme.greenSwatch,
                            onPrimary: CustomTheme.green,
                          ),
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          )),
                    ),
                  ],
                );
              }
              return _renderThumbnail();
            },
          );
  }
}

import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoContent extends StatefulWidget {
  final String path;
  final String thumbnailPath;
  final List<Widget> stackChildren;
  final bool isNetwork;
  const VideoContent(
      {Key? key,
      required this.path,
      required this.thumbnailPath,
      this.stackChildren = const [],
      this.isNetwork = true})
      : super(key: key);

  @override
  State<VideoContent> createState() => _VideoContentState();
}

class _VideoContentState extends State<VideoContent> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = widget.isNetwork
        ? VideoPlayerController.network(widget.path,
            videoPlayerOptions: VideoPlayerOptions(
              mixWithOthers: true,
            ))
        : VideoPlayerController.asset(widget.path,
            videoPlayerOptions: VideoPlayerOptions(
              mixWithOthers: true,
            ));
    _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        showControls: false,
        looping: true,
        allowMuting: true);
    _chewieController.setVolume(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ),
        ...widget.stackChildren,
      ],
    );
  }
}

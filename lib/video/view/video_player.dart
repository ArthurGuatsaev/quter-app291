import 'package:flutter/material.dart';
import 'package:quotex291/video/domain/models/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoModel video;
  const VideoPlayerWidget({super.key, required this.video});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController _controller =
      VideoPlayerController.networkUrl(
    Uri.parse(widget.video.video),
  )..initialize().then((_) {
          setState(() {});
        });
  // late final flickManager = FlickManager(
  // videoPlayerController: VideoPlayerController.networkUrl("url"),
  // );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(_controller),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        },
                      );
                    },
                    child: Center(
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(
                  //       () {
                  //         _controller.value.isPlaying
                  //             ? _controller.pause()
                  //             : _controller.play();
                  //       },
                  //     );
                  //   },
                  //   child: Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: Icon(
                  //       _controller.value.isPlaying
                  //           ? Icons.crop_free
                  //           : Icons.zoom_out_map,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
    );
  }
}

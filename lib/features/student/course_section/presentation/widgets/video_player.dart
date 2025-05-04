import 'package:assam_edu/features/student/course_section/presentation/widgets/basic_overlay_widget.dart';
import 'package:assam_edu/features/student/course_section/presentation/widgets/land_scape_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const VideoPlayerWidget({super.key, required this.controller});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  // @override
  // void initState() {
  //   super.initState();
  //   // print("Video URI: ${widget.uri}"); // Print the URI
  //   controller = VideoPlayerController.networkUrl(widget.uri)
  //     ..addListener(() => setState(() {}))
  //     ..setLooping(true)
  //     ..initialize().then((_) => controller.play());
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return widget.controller.value.isInitialized
        ? Container(
            alignment: Alignment.topCenter,
            child: buildVideo(),
          )
        : const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget buildVideo() => Stack(children: <Widget>[
        buildVideoPlayer(),
        Positioned.fill(
            child: BasicOVerLayWidget(controller: widget.controller)),
        Positioned(
          top: 5,
          left: 5,
          child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        LandscapePlayerPage(controller: widget.controller),
                  ),
                );
              },
              icon: const Icon(
                Icons.fullscreen,
                color: Colors.white,
                size: 35,
              )),
        ),
      ]);

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: VideoPlayer(widget.controller));
}

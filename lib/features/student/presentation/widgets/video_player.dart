import 'package:assam_edu/features/student/presentation/widgets/basic_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  // final VideoPlayerController? controller;
  final Uri uri;
  const VideoPlayerWidget({
    super.key,
    required this.uri,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    // print("Video URI: ${widget.uri}"); // Print the URI
    controller = VideoPlayerController.networkUrl(widget.uri)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
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
        Positioned.fill(child: BasicOVerLayWidget(controller: controller))
      ]);

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller));
}

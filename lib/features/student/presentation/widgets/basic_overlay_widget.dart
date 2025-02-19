import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOVerLayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  const BasicOVerLayWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          controller.value.isPlaying ? controller.pause() : controller.play(),
      child: Stack(
        children: [
          buildPlay(),
          Positioned(bottom: 0, left: 0, right: 0, child: buildIndicator())
        ],
      ),
    );
  }

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 20,
          ),
        );
}

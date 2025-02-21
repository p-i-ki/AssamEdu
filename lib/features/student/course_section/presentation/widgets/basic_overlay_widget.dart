import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOVerLayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOVerLayWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          controller.value.isPlaying ? controller.pause() : controller.play(),
      child: Stack(
        children: [
          buildPlay(),
          controller.value.isPlaying
              ? Container(
                  // color: Colors.redAccent.withValues(alpha: 0.2),
                  )
              : Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    //color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4), // Add padding
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Distribute space
                      children: [
                        ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, VideoPlayerValue value, child) {
                            return Text(
                              _videoDuration(value.position),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          // Expand the indicator
                          child: buildIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildIndicator() => VideoProgressIndicator(
        padding: const EdgeInsets.all(0),
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
            size: 30,
          ),
        );

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}

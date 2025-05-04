import 'dart:async';

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
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: IconButton(
          //       onPressed: () {
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) =>
          //                 LandscapePlayerPage(controller: controller),
          //           ),
          //         );
          //       },
          //       icon: const Icon(
          //         Icons.fullscreen,
          //         color: Colors.white,
          //         size: 35,
          //       )),
          // ),
          buildPlay(),
          controller.value.isPlaying
              ? Positioned(
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
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          _videoDuration(controller.value.duration),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  // color: Colors.redAccent.withValues(alpha: 0.2),
                  )
        ],
      ),
    );
  }

  Widget buildIndicator() => VideoProgressIndicator(
        padding: const EdgeInsets.all(0),
        controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => PlayPauseOverlay(controller: controller);

  // Widget buildPlay() => Container(
  //       alignment: Alignment.center,
  //       color: Colors.black26,
  //       child: IconButton(
  //         onPressed: () {
  //           controller.value.isPlaying ? controller.pause() : controller.play();
  //         },
  //         icon: Icon(
  //           controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
  //           color: Colors.white,
  //           size: 30,
  //         ),
  //       ),
  //     );

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}

class PlayPauseOverlay extends StatefulWidget {
  final VideoPlayerController controller; // Or any controller you use

  const PlayPauseOverlay({super.key, required this.controller});

  @override
  State<PlayPauseOverlay> createState() => _PlayPauseOverlayState();
}

class _PlayPauseOverlayState extends State<PlayPauseOverlay> {
  double _opacity = 1.0;
  Timer? _hideTimer;

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
    } else {
      widget.controller.play();
    }

    _showControlsTemporarily();
  }

  void _showControlsTemporarily() {
    setState(() {
      _opacity = 1.0;
    });

    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(
            widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}

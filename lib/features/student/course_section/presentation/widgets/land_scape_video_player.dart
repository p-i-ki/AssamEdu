import 'package:assam_edu/features/student/course_section/presentation/widgets/basic_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class LandscapePlayerPage extends StatefulWidget {
  const LandscapePlayerPage({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<LandscapePlayerPage> createState() => _LandscapePlayerPageState();
}

class _LandscapePlayerPageState extends State<LandscapePlayerPage> {
  Future _landscapeMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future _setOrientationBack() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    _landscapeMode();
    super.initState();
  }

  @override
  void dispose() {
    _setOrientationBack();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          VideoPlayer(widget.controller),
          Positioned.fill(
              child: BasicOVerLayWidget(controller: widget.controller)),
        ],
      );
}

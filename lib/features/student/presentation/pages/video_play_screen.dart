import 'dart:convert';

import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/utlis/percentage_bar.dart';
import 'package:assam_edu/features/student/domain/entity/course.dart';
import 'package:assam_edu/features/student/presentation/bloc/home_page_bloc.dart';
import 'package:assam_edu/features/student/presentation/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';

class VideoPlaySection extends StatefulWidget {
  const VideoPlaySection({super.key});

  @override
  State<VideoPlaySection> createState() => _VideoPlaySectionState();
}

class _VideoPlaySectionState extends State<VideoPlaySection> {
  //final VideoPlayerController controller = VideoPlayerController();
  Map<dynamic, dynamic> data = {};
  bool _isCourseFetched = false;
  late final Course courseData;
  bool _isCourseFetchedError = false;
  bool _isVideoPlayed = false;
  int index = 1;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as Map;
    // add event to fetch courses
  }

  void _fetchCourse() {
    if (data.isNotEmpty && !_isCourseFetched) {
      final courseReq = CourseVideoRequestEntity(courseId: data["courseId"]);
      context
          .read<HomePageBloc>()
          .add(CourseVideoFetch(requestEntity: courseReq));
    }
  }

  // void initializeVideoPlayer(Uri url) {
  //   controller = VideoPlayerController.networkUrl(url)
  //     ..addListener(() => setState(() {}))
  //     ..setLooping(true)
  //     ..initialize().then((_) => controller.play());
  // }

  @override
  Widget build(BuildContext context) {
    _fetchCourse();
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is CourseVideoFetchError) {
          EasyLoading.dismiss();
          _isCourseFetchedError = true;
        }
        if (state is CourseVideoFetchSuccess) {
          EasyLoading.dismiss();
          courseData = state.responseEntity;
          _isCourseFetched = true;
          _isCourseFetchedError = false;
        }
      },
      builder: (context, state) {
        if (state is CourseVideoFetchLoading) {
          EasyLoading.show(
            indicator: const CircularProgressIndicator(),
            maskType: EasyLoadingMaskType.clear,
            dismissOnTap: true,
          );
        }
        return _isCourseFetched
            ? Scaffold(
                backgroundColor: HexColor('FFFFFF'),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 30, top: 20),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      _isVideoPlayed
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.deepOrange,
                              child:
                                  _buildVideoPlayer(), // Call a function to build the video player
                            )
                          : Container(
                              height: 220,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: HexColor('DFF8FF'),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        courseData.title!,
                                        // 'Python Course',
                                        style: TextStyle(
                                            color: HexColor('134C5D'),
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'by Nila Man',
                                        style: TextStyle(
                                          color: HexColor('134C5D'),
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 30),
                                      RichText(
                                        text: TextSpan(
                                          text: '20',
                                          style: TextStyle(
                                            color: HexColor('134C5D'),
                                            fontSize: 24,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: '/40 chapters completed',
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      const SizedBox(
                                        // color: Colors.red,
                                        width: 160,
                                        height: 25,
                                        child: Center(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: PercentageBar(
                                              completedChapters: 9,
                                              totalChapters: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${AppConstants.SERVER_API_URL}/${courseData.thumbnailUrl}'),
                                            // image: AssetImage('assets/pyhton.jpg'),
                                            fit: BoxFit.fitWidth)),
                                  ),
                                ],
                              ),
                            ),
                      const SizedBox(height: 5),
                      Container(
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: HexColor('FFF0D3'),
                        ),
                        child: ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 22, top: 8, bottom: 5),
                            itemCount: courseData.sections!.length,
                            itemBuilder: (_, index) {
                              int a = index + 1;
                              return Container(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_box_outlined,
                                          size: 24,
                                          color: HexColor('515151'),
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          '$a. ${courseData.sections?[a - 1].sectionName}',
                                          // '$a. Introduction to Python',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: HexColor('515151')),
                                        ),
                                        Expanded(child: Container()),
                                        Icon(
                                          Icons.file_download_outlined,
                                          size: 20,
                                          color: HexColor('515151'),
                                        ),
                                        const SizedBox(width: 5),
                                        Icon(
                                          Icons.note_add_outlined,
                                          size: 20,
                                          color: HexColor('515151'),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 35.0, right: 4),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                index = a;
                                                _isVideoPlayed = true;
                                              });
                                            },
                                            child: Icon(
                                              Icons.play_circle_fill,
                                              size: 20,
                                              color: HexColor('515151'),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '8 min',
                                          style: TextStyle(
                                              color: HexColor('515151'),
                                              fontSize: 10),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor('134C5D'),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            child: Text(
                              'Get Certificate',
                              style: TextStyle(
                                fontSize: 16,
                                color: HexColor('FDF5E7'),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              )
            : _isCourseFetchedError
                ? TextButton(
                    onPressed: () {
                      _fetchCourse();
                    },
                    child: const Text(
                      "Retry",
                      style: TextStyle(color: Colors.black),
                    ))
                : Container(
                    color: Colors.red,
                  );
      },
    );
  }

  Widget _buildVideoPlayer() {
    if (courseData.sections != null &&
        courseData.sections!.isNotEmpty &&
        courseData.sections![index - 1].videos != null &&
        courseData.sections![index - 1].videos!.isNotEmpty) {
      final video = courseData.sections![index - 1].videos![0];

      if (video.url != null) {
        try {
          final List<dynamic> urlList = jsonDecode(video.url!) as List;
          if (urlList.isNotEmpty) {
            final firstUrl = urlList[0] as String;

            final Uri parsedVideoUrl = Uri.parse(firstUrl);
            final String videoPath = parsedVideoUrl.path;

            const String baseUrl = AppConstants.SERVER_API_URL;

            // Correct way to combine base URL and path:
            final Uri finalUri = Uri.parse(baseUrl).resolve(videoPath);
            final String finalUrl = finalUri.toString();

            final uri = Uri.parse(finalUrl);

            print("Final Video URL: $uri");

            return VideoPlayerWidget(uri: uri);
          } else {
            print('URL list is empty');
            return const Center(
                child: Text('URL list is empty')); // Return a widget
          }
        } catch (e) {
          print('Error decoding URL: $e');
          return const Center(
              child: Text('Error decoding URL')); // Return a widget
        }
      } else {
        print('URL is null');
        return const Center(child: Text('URL is null')); // Return a widget
      }
    } else {
      return const Center(
          child: Text('Video data is missing')); // Return a widget
    }
  }
}

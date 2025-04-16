// import 'dart:convert';

// import 'package:assam_edu/core/app_constants/app_constants.dart';
// import 'package:assam_edu/core/common/widgets/app_style.dart';
// import 'package:assam_edu/core/common/widgets/resuable_text.dart';
// import 'package:assam_edu/core/entities/course.dart';
// import 'package:assam_edu/core/utlis/show_snack_bar.dart';
// import 'package:assam_edu/features/educator/course_detail/presentation/bloc/educator_course_detail_screen_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:video_player/video_player.dart';

// import '../../../../../core/common/widgets/custom_button.dart';
// import '../../../../student/course_section/presentation/widgets/video_player.dart';

// class EducatorCourseDetailSceen extends StatefulWidget {
//   const EducatorCourseDetailSceen({super.key});

//   @override
//   State<EducatorCourseDetailSceen> createState() =>
//       _EducatorCourseDetailSceenState();
// }

// class _EducatorCourseDetailSceenState extends State<EducatorCourseDetailSceen> {
//   Map<dynamic, dynamic> data = {};
//   late final Course courseData;

//   VideoPlayerController? controller;

//   bool _isCourseFetched = false;
//   bool _isCourseFetchedError = false;
//   bool _isVideoPlayed = false;
//   int _sectionNum = 1;
//   int _vidoeNum = 1;
//   bool _isVideoInitialized = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     data = ModalRoute.of(context)!.settings.arguments as Map;
//     // add event to fetch courses
//   }

//   void _getSections() {
//     if (context.mounted && data['courseId'].toString().isNotEmpty) {
//       final req = CourseVideoRequestEntity(courseId: data['courseId'] ?? "");
//       context
//           .read<EducatorCourseDetailScreenBloc>()
//           .add(GetEducatorCourseSections(req: req));
//     }
//   }

//   void initializeVideoPlayer(Uri url) async {
//     if (controller != null) {
//       await controller!.dispose(); // Dispose of the old controller
//       controller = null;
//       _isVideoInitialized = false;
//     }
//     controller = VideoPlayerController.networkUrl(url);
//     controller!.addListener(() {
//       if (controller!.value.isInitialized && !_isVideoInitialized) {
//         if (mounted) {
//           setState(() {
//             _isVideoInitialized = true;
//             controller!.play();
//           });
//         }
//       }
//     });
//     try {
//       await controller!.initialize();
//       if (mounted) {
//         setState(() {
//           // Initialization successful, update state
//         });
//       }
//     } catch (e) {
//       // Handle initialization error, if needed
//       print("Video initialization error: $e");
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose(); // Dispose when the widget is removed
//     super.dispose();
//   }
//   // void initializeVideoPlayer(Uri url) {
//   //   controller = VideoPlayerController.networkUrl(url);

//   //   controller!.addListener(() {
//   //     if (controller!.value.isInitialized && !_isVideoInitialized) {
//   //       // Use addPostFrameCallback to avoid setState during build
//   //       WidgetsBinding.instance.addPostFrameCallback((_) {
//   //         if (mounted) {
//   //           setState(() {
//   //             _isVideoInitialized = true; // Set flag once initialized
//   //             controller!.play();
//   //           });
//   //         }
//   //       });
//   //     }
//   //   });

//   //   if (!_isVideoInitialized) {
//   //     // Initialize only once
//   //     controller!.initialize();
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<EducatorCourseDetailScreenBloc,
//         EducatorCourseDetailScreenState>(
//       listener: (context, state) {
//         if (state is EducatorGetCourseSectionError) {
//           _isCourseFetched = false;
//           showSnackBar(context, state.error);
//         }
//         if (state is EducatorGetCourseSectionSuccess) {
//           _isCourseFetched = true;
//           courseData = state.res;
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: HexColor('FFFFFF'),
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(30),
//             child: AppBar(),
//           ),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
//             child: Column(
//               children: [
//                 _isVideoPlayed
//                     ? SizedBox(
//                         height: 230.h,
//                         width: MediaQuery.of(context).size.width,
//                         //color: Colors.deepOrange,
//                         child:
//                             _buildVideoPlayer(), // Call a function to build the video player
//                       )
//                     : Container(
//                         padding: const EdgeInsets.only(left: 4, right: 4),
//                         height: 220,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                             //color: HexColor('FFF0D3'),
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage(
//                                     '${AppConstants.SERVER_API_URL}/${data["thumbnailUrl"]}'))),
//                       ),
//                 const SizedBox(height: 8),
//                 // Blue Container
//                 Container(
//                   height: 250,
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.all(5),
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                       color: HexColor('3572EF'),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ReusableText(
//                           text: "Title: ${data['title']}",
//                           style: appStyle(
//                               size: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700)),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       DecoratedBox(
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.all(Radius.circular(6))),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             "Price: ₹${data["price"]}",
//                             style: TextStyle(
//                                 color: HexColor('515151'),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       ReusableText(
//                           text: "Created: ${data['createdAt']}",
//                           style: appStyle(
//                               size: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.normal)),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         "Description: ${data['desc']}",
//                         style: const TextStyle(color: Colors.white),
//                         softWrap: true,
//                         overflow: TextOverflow.ellipsis,
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 // Add section Button
//                 state is EducatorGetCourseSectionLoading
//                     ? Container(
//                         color: Colors.white,
//                         child: const CircularProgressIndicator(
//                           color: Colors.blueAccent,
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 6),
//                         child: Row(
//                           children: [
//                             Expanded(
//                                 child: CustomButton(
//                                     text: "Delete Course",
//                                     backgroungColor: HexColor('050C9C'),
//                                     textStyle: appStyle(
//                                         size: 14,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w700),
//                                     borderSide: const BorderSide(),
//                                     customFun: () {
//                                       // setState(() {
//                                       //   //  _addMoreDetails = true;
//                                       // });
//                                     })),
//                             const SizedBox(width: 5),
//                             Expanded(
//                               child: CustomButton(
//                                   text: "Load Sections",
//                                   backgroungColor: Colors.white,
//                                   textStyle: appStyle(
//                                       size: 14,
//                                       color: HexColor('050C9C'),
//                                       fontWeight: FontWeight.w700),
//                                   borderSide: BorderSide(
//                                       color: HexColor('050C9C'), width: 2),
//                                   customFun: () {
//                                     _getSections();
//                                   }),
//                             ),
//                           ],
//                         ),
//                       ),
//                 const SizedBox(height: 5),
//                 // Sections Details
//                 _isCourseFetched && state is EducatorGetCourseSectionSuccess
//                     ? Container(
//                         height: 500,
//                         width: MediaQuery.of(context).size.width,
//                         margin: const EdgeInsets.all(5),
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: HexColor('FFF0D3'),
//                         ),
//                         child: ListView.builder(
//                             padding: const EdgeInsets.only(
//                                 left: 22, top: 8, bottom: 5),
//                             itemCount: courseData.sections!.length,
//                             itemBuilder: (_, index) {
//                               //  int a = index + 1;  // Section is represented by "a": 1,2,3..
//                               return Container(
//                                 padding:
//                                     const EdgeInsets.only(top: 8, bottom: 8),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.check_box_outlined,
//                                           size: 24,
//                                           color: HexColor('515151'),
//                                         ),
//                                         const SizedBox(width: 2),
//                                         Text(
//                                           '${index + 1}. ${courseData.sections?[index].sectionName}',
//                                           // '$a. Introduction to Python',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: HexColor('515151')),
//                                         ),
//                                         Expanded(child: Container()),
//                                         Icon(
//                                           Icons.edit,
//                                           size: 20,
//                                           color: HexColor('515151'),
//                                         ),
//                                         const SizedBox(width: 5),
//                                         Icon(
//                                           Icons.note_add_outlined,
//                                           size: 20,
//                                           color: HexColor('515151'),
//                                         ),
//                                         const SizedBox(width: 10),
//                                       ],
//                                     ),
//                                     Container(
//                                       color: Colors.white,
//                                       width: 300,
//                                       height: 50,
//                                       padding: const EdgeInsets.all(5),
//                                       child: ListView.builder(
//                                         itemCount: courseData
//                                             .sections?[index].videos!.length,
//                                         itemBuilder: (_, indx) {
//                                           return Row(
//                                             children: [
//                                               Text(
//                                                 '${indx + 1}. ${courseData.sections![index].videos![indx].title}',
//                                                 style: TextStyle(
//                                                     color: HexColor('515151'),
//                                                     fontSize: 10),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 35.0, right: 4),
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       //  index = a;
//                                                       _sectionNum = index;
//                                                       _vidoeNum = indx;
//                                                       _isVideoPlayed = true;
//                                                     });
//                                                   },
//                                                   child: Icon(
//                                                     Icons.play_circle_fill,
//                                                     size: 20,
//                                                     color: HexColor('515151'),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 '8 min',
//                                                 style: TextStyle(
//                                                     color: HexColor('515151'),
//                                                     fontSize: 10),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             }),
//                       )
//                     : const SizedBox()
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildVideoPlayer() {
//     if (courseData.sections != null &&
//         courseData.sections!.isNotEmpty &&
//         courseData.sections![_sectionNum].videos != null &&
//         courseData.sections![_sectionNum].videos!.isNotEmpty) {
//       final video = courseData.sections![_sectionNum].videos![_vidoeNum];
//       print("--- video tapedd ----->>>> ${video.title}   ${video.url}");
//       if (video.url != null) {
//         try {
//           final List<dynamic> urlList = jsonDecode(video.url!) as List;
//           if (urlList.isNotEmpty) {
//             final firstUrl = urlList[0] as String;
//             final Uri parsedVideoUrl = Uri.parse(firstUrl);
//             final String videoPath = parsedVideoUrl.path;
//             const String baseUrl = AppConstants.SERVER_API_URL;
//             final Uri finalUri = Uri.parse(baseUrl).resolve(videoPath);
//             final String finalUrl = finalUri.toString();
//             final uri = Uri.parse(finalUrl);
//             // Initialize the video player
//             initializeVideoPlayer(uri);
//             return _isVideoInitialized
//                 ? VideoPlayerWidget(controller: controller!)
//                 : const Center(child: CircularProgressIndicator());
//           } else {
//             return const Center(
//                 child: Text('URL list is empty')); // Return a widget
//           }
//         } catch (e) {
//           return const Center(
//               child: Text("Something went wrong!")); // Return a widget
//         }
//       } else {
//         return const Center(child: Text('URL is null')); // Return a widget
//       }
//     } else {
//       return const Center(
//           child: Text('Video data is missing')); // Return a widget
//     }

//     // Widget _buildVideoPlayer() {
//     //   if (courseData.sections != null &&
//     //       courseData.sections!.isNotEmpty &&
//     //       courseData.sections![_sectionNum].videos != null &&
//     //       courseData.sections![_sectionNum].videos!.isNotEmpty) {
//     //     final video = courseData.sections![_sectionNum].videos![_vidoeNum];
//     //     print("--- video tapedd ----->>>> ${video.title}   ${video.url}");
//     //     if (video.url != null) {
//     //       try {
//     //         final List<dynamic> urlList = jsonDecode(video.url!) as List;
//     //         if (urlList.isNotEmpty) {
//     //           final firstUrl = urlList[0] as String;

//     //           final Uri parsedVideoUrl = Uri.parse(firstUrl);
//     //           final String videoPath = parsedVideoUrl.path;

//     //           const String baseUrl = AppConstants.SERVER_API_URL;

//     //           // Correct way to combine base URL and path:
//     //           final Uri finalUri = Uri.parse(baseUrl).resolve(videoPath);
//     //           final String finalUrl = finalUri.toString();

//     //           final uri = Uri.parse(finalUrl);
//     //           if (controller == null) {
//     //             // Check if URL has changed
//     //             initializeVideoPlayer(uri);
//     //             _isVideoInitialized = false; // Reset initialization flag
//     //            // setState(() {});
//     //           }

//     //           return _isVideoInitialized
//     //               ? VideoPlayerWidget(controller: controller!)
//     //               : const Center(child: CircularProgressIndicator());
//     //         } else {
//     //           //  print('URL list is empty');
//     //           return const Center(
//     //               child: Text('URL list is empty')); // Return a widget
//     //         }
//     //       } catch (e) {
//     //         // print('Error decoding URL: $e');
//     //         return const Center(
//     //             child: Text("Something went wrong!")); // Return a widget
//     //       }
//     //     } else {
//     //       // print('URL is null');
//     //       return const Center(child: Text('URL is null')); // Return a widget
//     //     }
//     //   } else {
//     //     return const Center(
//     //         child: Text('Video data is missing')); // Return a widget
//     //   }
//     // }
//   }
// }

import 'dart:async'; // Import dart:async for Timer
import 'dart:convert';
import 'package:assam_edu/core/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/app_constants/app_constants.dart';
import '../../../../../core/common/widgets/app_style.dart';
import '../../../../../core/common/widgets/custom_button.dart';
import '../../../../../core/common/widgets/resuable_text.dart';
import '../../../../../core/entities/course.dart';
import '../../../../../core/utlis/show_snack_bar.dart';
import '../../../../student/course_section/presentation/widgets/video_player.dart';
import '../../presentation/bloc/educator_course_detail_screen_bloc.dart';

class EducatorCourseDetailSceen extends StatefulWidget {
  const EducatorCourseDetailSceen({super.key});

  @override
  State<EducatorCourseDetailSceen> createState() =>
      _EducatorCourseDetailSceenState();
}

class _EducatorCourseDetailSceenState extends State<EducatorCourseDetailSceen> {
  Map<dynamic, dynamic> data = {};
  Course? courseData;
  bool _loadSectionsTapped = false;
  VideoPlayerController? controller;
  bool _isCourseFetched = false;
  //bool _isCourseFetchedError = false;
  bool _isVideoPlayed = false;
  int _sectionNum = 0;
  int _vidoeNum = 0;
  bool _isVideoInitialized = false;

  Timer? _debounceTimer; // Timer for debouncing

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as Map;
  }

  void _getSections() {
    if (context.mounted && data['courseId'].toString().isNotEmpty) {
      final req = CourseVideoRequestEntity(courseId: data['courseId'] ?? "");
      context
          .read<EducatorCourseDetailScreenBloc>()
          .add(GetEducatorCourseSections(req: req));
    }
  }

  Future<void> initializeVideoPlayer(Uri url) async {
    if (controller != null) {
      await controller!.pause(); // Pause the current video
      await controller!.dispose(); // Dispose of the old controller
      controller = null;
      _isVideoInitialized = false;
    }

    controller = VideoPlayerController.networkUrl(url);

    controller!.addListener(() {
      if (controller!.value.isInitialized && !_isVideoInitialized) {
        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
            controller!.play();
          });
        }
      }
    });

    try {
      await controller!.initialize();
      if (mounted) {
        setState(() {
          // Initialization successful, update state
        });
      }
    } catch (e) {
      // Handle initialization error, if needed
      print("Video initialization error: $e");
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel(); // Cancel the timer if it's running
    controller?.dispose();
    super.dispose();
  }

  void _onVideoTap(int sectionIndex, int videoIndex) {
    // Debounce the video change
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 200), () async {
      // Use a short delay (e.g., 200ms)
      setState(() {
        _sectionNum = sectionIndex;
        _vidoeNum = videoIndex;
        _isVideoPlayed = true;
        _isVideoInitialized = false; // Reset the flag
      });

      if (courseData!.sections != null &&
          courseData!.sections!.isNotEmpty &&
          courseData!.sections![_sectionNum].videos != null &&
          courseData!.sections![_sectionNum].videos!.isNotEmpty) {
        final video = courseData!.sections![_sectionNum].videos![_vidoeNum];
        if (video.url != null) {
          try {
            final List<dynamic> urlList = jsonDecode(video.url!) as List;
            if (urlList.isNotEmpty) {
              final firstUrl = urlList[0] as String;
              final Uri parsedVideoUrl = Uri.parse(firstUrl);
              final String videoPath = parsedVideoUrl.path;
              String baseUrl = AppConstants.SERVER_API_URL;
              final Uri finalUri = Uri.parse(baseUrl).resolve(videoPath);
              final String finalUrl = finalUri.toString();
              final uri = Uri.parse(finalUrl);

              await initializeVideoPlayer(uri); // Await the initialization
            } else {
              // Handle empty URL list
              showSnackBar(context, "Url List is Empty");
            }
          } catch (e) {
            // Handle error decoding URL
            print("--- Error in decoding the URL ---");
          }
        } else {
          // Handle null URL
          print("--- URL is Null ---");
        }
      } else {
        // Handle missing video data
        print("--- Video data is missing ---");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final url = data['thumbnailUrl'].contains('http://10.3.0.253:4000')
        ? data['thumbnailUrl']
        : "${AppConstants.SERVER_API_URL}/${data['thumbnailUrl']}";
    return BlocConsumer<EducatorCourseDetailScreenBloc,
        EducatorCourseDetailScreenState>(
      listener: (context, state) {
        if (state is EducatorGetCourseSectionError) {
          _isCourseFetched = false;
          showSnackBar(context, state.error);
        }
        if (state is EducatorGetCourseSectionSuccess) {
          _isCourseFetched = true;
          courseData = state.res;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: HexColor('FFFFFF'),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: AppBar(),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
            child: Column(
              children: [
                _isVideoPlayed
                    ? SizedBox(
                        height: 230.h,
                        width: MediaQuery.of(context).size.width,
                        child: _buildVideoPlayer(),
                      )
                    : Container(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(url))),
                      ),
                const SizedBox(height: 8),
                // Blue Container
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: HexColor('3572EF'),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: "Title: ${data['title']}",
                          style: appStyle(
                              size: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 5,
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Price: ₹${data["price"]}",
                            style: TextStyle(
                                color: HexColor('515151'),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ReusableText(
                          text: "Created: ${data['createdAt']}",
                          style: appStyle(
                              size: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Description: ${data['desc']}",
                        style: const TextStyle(color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Add section Button
                state is EducatorGetCourseSectionLoading
                    ? Container(
                        margin: const EdgeInsets.only(top: 100),
                        color: Colors.white,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomButton(
                                    text: "Add Section",
                                    backgroungColor: HexColor('050C9C'),
                                    textStyle: appStyle(
                                        size: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                    borderSide: const BorderSide(),
                                    customFun: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.ADD_SECTION,
                                          arguments: {
                                            'courseId': data['courseId'],
                                            'courseName': data['title'],
                                          });
                                    })),
                            const SizedBox(width: 5),
                            Expanded(
                              child: CustomButton(
                                text: _isCourseFetched
                                    ? "Refresh Sections"
                                    : "Load Sections",
                                backgroungColor: Colors.white,
                                textStyle: appStyle(
                                    size: 14,
                                    color: HexColor('050C9C'),
                                    fontWeight: FontWeight.w700),
                                borderSide: BorderSide(
                                    color: HexColor('050C9C'), width: 2),
                                customFun: () {
                                  // Prevent immediate re-taps
                                  if (_loadSectionsTapped) return;
                                  setState(() {
                                    _loadSectionsTapped = true;
                                  });
                                  // Dispose of video controller safely
                                  if (controller != null) {
                                    controller!.dispose();
                                    setState(() {
                                      _isVideoInitialized = false;
                                      _isVideoPlayed = false;
                                      controller =
                                          null; // Ensure it's reset properly
                                    });
                                  }
                                  // Call _getSections() asynchronously after data is loaded or use Future.delay()
                                  _getSections();
                                  // Reset _loadSectionsTapped with a slight delay to avoid spamming
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    setState(() {
                                      _loadSectionsTapped = false;
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 5),
                // Sections Details
                _isCourseFetched && state is EducatorGetCourseSectionSuccess
                    ? Container(
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
                            itemCount: courseData!.sections!.length,
                            itemBuilder: (_, index) {
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
                                          '${index + 1}. ${courseData!.sections?[index].sectionName}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: HexColor('515151')),
                                        ),
                                        Expanded(child: Container()),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, AppRoutes.ADD_SECTION,
                                                arguments: {
                                                  'courseName':
                                                      courseData!.title,
                                                  'courseId':
                                                      courseData!.courseId,
                                                  'sectionId': courseData!
                                                      .sections![index]
                                                      .sectionId,
                                                  'sectionName': courseData!
                                                      .sections![index]
                                                      .sectionName,
                                                });
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: HexColor('515151'),
                                          ),
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
                                    Container(
                                      color: Colors.white,
                                      width: 300,
                                      height: 50,
                                      padding: const EdgeInsets.all(5),
                                      child: ListView.builder(
                                        itemCount: courseData!
                                            .sections?[index].videos!.length,
                                        itemBuilder: (_, indx) {
                                          return Row(
                                            children: [
                                              Text(
                                                '${indx + 1}. ${courseData!.sections![index].videos![indx].title}',
                                                style: TextStyle(
                                                    color: HexColor('515151'),
                                                    fontSize: 10),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 35.0, right: 4),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _onVideoTap(index,
                                                        indx); // Use the debounced tap
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
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoPlayer() {
    // At this point, controller should already be initialized by _onVideoTap()
    // Just check if the video has finished initializing
    return _isVideoInitialized && controller != null
        ? VideoPlayerWidget(controller: controller!)
        : const Center(child: CircularProgressIndicator());
  }
}

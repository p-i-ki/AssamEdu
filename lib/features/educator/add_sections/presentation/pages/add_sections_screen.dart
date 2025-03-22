import 'dart:io';

import 'package:assam_edu/core/common/widgets/app_style.dart';
import 'package:assam_edu/core/common/widgets/cstm_text_form_field.dart';
import 'package:assam_edu/core/common/widgets/custom_button.dart';
import 'package:assam_edu/core/utlis/show_snack_bar.dart';
import 'package:assam_edu/features/educator/add_sections/domain/entity/add_section.dart';
import 'package:assam_edu/features/educator/add_sections/presentation/bloc/add_section_bloc.dart';
import 'package:assam_edu/features/student/course_section/presentation/widgets/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart'; // Import video_player

class AddSectionsScreen extends StatefulWidget {
  const AddSectionsScreen({super.key});

  @override
  State<AddSectionsScreen> createState() => _AddSectionsScreenState();
}

class _AddSectionsScreenState extends State<AddSectionsScreen> {
  final TextEditingController _sectionNameController = TextEditingController();
  final TextEditingController _videoTitleController = TextEditingController();
  dynamic data;
  String? _videoFilePath;
  VideoPlayerController? _videoPlayerController; // Video player controller
  AddSectionNameResEntity? res;
  String? _sectionId;
  //String? _courseId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Need to pass courseId..
    data = ModalRoute.of(context)!.settings.arguments as Map;
  }

  void _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4'],
        allowMultiple: false);
    if (result == null) return;
    final file = result.files.first;
    _videoFilePath = file.path;

    // Initialize video player controller
    _videoPlayerController = VideoPlayerController.file(File(_videoFilePath!))
      ..initialize().then((_) {
        setState(() {});
      });

    setState(() {});
  }

  String _addSectionName() {
    if (data['sectionName'].toString() != 'null') {
      _sectionNameController.text = data['sectionName'];
    }

    if (_sectionNameController.value.text.isEmpty) {
      return "Please Add Section Name";
    }

    context.read<AddSectionBloc>().add(
          AddSectionNameEvent(
              sectionName: _sectionNameController.text.trim(),
              courseId: data['courseId']),
        );
    return "";
  }

  String _addVideo() {
    if (_videoTitleController.value.text.isEmpty) {
      return "Please Add Video Title!";
    }

    final secId =
        data['sectionId'].toString() != 'null' ? data['sectionId'] : _sectionId;

    if (secId == null) {
      return "Please Add Section First!";
    }

    if (_videoFilePath == null ||
        _videoFilePath == "" ||
        _videoFilePath == 'null') {
      return "Please Add Video File!";
    }

    context.read<AddSectionBloc>().add(AddSectionVideoEvent(
          sectionId: secId!,
          courseId: data['courseId'],
          video: File(_videoFilePath ?? ""),
          title: _videoTitleController.text.trim(),
        ));
    return "";
  }

  @override
  void dispose() {
    _sectionNameController.dispose();
    _videoTitleController.dispose();
    _videoPlayerController?.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddSectionBloc, AddSectionState>(
      listener: (context, state) {
        if (state is AddSectionNameError) {
          showSnackBar(context, state.error);
        }
        if (state is AddSectionNameSuccess) {
          res = state.res;
          _sectionId = res?.sections?[res!.sections!.length - 1].sectionId;
          showSnackBar(
              context, "Section Added Successfully! you can now add videos!");
        }
        if (state is AddSectionVideoError) {
          showSnackBar(context, state.error);
        }
        if (state is AddSectionVideoSuccess) {
          // res = state.res;
          // _sectionId = res?.sections?[res!.sections!.length - 1].sectionId;
          showSnackBar(context, "Video Added Successfully!");
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: data['courseName'].toString() != "null"
                  ? Center(child: Text('${data['courseName']}'))
                  : const Text("New"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    height: 500,
                    padding:
                        const EdgeInsets.only(top: 30, left: 12, right: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 0.7)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Section Name ',
                              style: TextStyle(
                                fontSize: 18,
                                color: HexColor('135063'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              height: 40,
                              width: 150,
                              padding: const EdgeInsets.all(4),
                              child: CstmTextFormField(
                                controller: _sectionNameController,
                                hintText:
                                    data['sectionName'] ?? "Add section name",
                                fillColor: HexColor('3572EF'),
                                maxLines: 2,
                                validator: (value) =>
                                    value!.isEmpty ? 'required' : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        state is AddSectionNameLoading
                            ? Container(
                                color: Colors.white,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.blueAccent),
                                ),
                              )
                            : SizedBox(
                                width: 150,
                                child: CustomButton(
                                    text: "Add Section",
                                    backgroungColor: Colors.white,
                                    textStyle: appStyle(
                                        size: 14,
                                        color: HexColor('050C9C'),
                                        fontWeight: FontWeight.w700),
                                    borderSide: BorderSide(
                                        color: HexColor('050C9C'), width: 2),
                                    customFun: () {
                                      final String err = _addSectionName();
                                      if (err.isNotEmpty) {
                                        showSnackBar(context, err);
                                      }
                                    }),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Text(
                                'Video Title ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: HexColor('135063'),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                height: 40,
                                width: 150,
                                padding: const EdgeInsets.all(4),
                                child: CstmTextFormField(
                                  controller: _videoTitleController,
                                  hintText: "Add video title",
                                  maxLines: 2,
                                  fillColor: HexColor('3572EF'),
                                  validator: (value) =>
                                      value!.isEmpty ? 'required' : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // here the picked video should show
                        GestureDetector(
                          onTap: () {
                            _pickVideo();
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(12)),
                            child: _videoPlayerController != null &&
                                    _videoPlayerController!.value.isInitialized
                                ? AspectRatio(
                                    aspectRatio: _videoPlayerController!
                                        .value.aspectRatio,
                                    child: VideoPlayerWidget(
                                      controller: _videoPlayerController!,
                                    ),
                                    // child: VideoPlayer(_videoPlayerController!),
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle_outline_outlined,
                                          size: 50,
                                          color: HexColor('BDBDBD'),
                                        ),
                                        Text(
                                          'Add Video',
                                          style: TextStyle(
                                              color: HexColor('BDBDBD')),
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: state is AddSectionVideoLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.blue,
                                )
                              : CustomButton(
                                  text: "Add Video",
                                  backgroungColor: HexColor('050C9C'),
                                  textStyle: appStyle(
                                      size: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  borderSide: BorderSide.none,
                                  customFun: () {
                                    final String err = _addVideo();
                                    if (err.isNotEmpty) {
                                      showSnackBar(context, err);
                                    }
                                  }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

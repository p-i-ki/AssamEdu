import 'dart:io';

import 'package:assam_edu/core/common/widgets/app_style.dart';
import 'package:assam_edu/core/common/widgets/custom_button.dart';
import 'package:assam_edu/core/config/db_config.dart';
import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/utlis/convert_blob_to_file.dart';
import 'package:assam_edu/core/utlis/show_snack_bar.dart';
import 'package:assam_edu/features/educator/course_create/domain/entities/create_course.dart';
import 'package:assam_edu/features/educator/course_create/presentation/bloc/create_course_bloc.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';

class CourseCreatePage extends StatefulWidget {
  const CourseCreatePage({super.key});

  @override
  State<CourseCreatePage> createState() => _CourseCreatePageState();
}

class _CourseCreatePageState extends State<CourseCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _courseTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  String? _thumbnailPath;

  int? courseId;

  Map<dynamic, dynamic>? data = {};
  Uint8List? imageBytes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    if (res == null) {
      return;
    }
    data = res as Map;
    loadInitialData();
  }

  void loadInitialData() async {
    _courseTitleController.text = data!["title"];
    _descriptionController.text = data!["desc"];
    _priceController.text = data!["price"];
    imageBytes = data!["thumbnailUrl"];
    courseId = data!["courseId"];
    debugPrint("--- CourseID: $courseId");
    debugPrint("--- ImageBytes: $imageBytes");
    if (imageBytes != null) {
      convertBytesToString(imageBytes!);
    }
  }

  void convertBytesToString(Uint8List imageB) async {
    final res = await convertBlobToFile(imageB, 'courseImage.jpg');
    _thumbnailPath = res.path;
    print("----- Final image in file format: $res");
    print("----- Thumbnail: $_thumbnailPath");
  }

  Future<void> _pickThumbnail() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (pickedFile != null) {
      // Get the selected file
      String? filePath = pickedFile.files.single.path;
      if (filePath != null) {
        // Use the picked image as needed, for example:
        setState(() {
          _thumbnailPath = filePath; // Store the image path in a state variable
        });
      }
    } else {
      // User canceled the picker
      print('No image selected');
      return;
    }
  }

  // validate and save or pass to api call..

  void _createCourse(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_thumbnailPath == null || _thumbnailPath!.isEmpty) {
        return showSnackBar(context, 'Thumbnail is required');
      }
//++++++ We may use GetIt here in future ++++++++
      final course = CourseCreateRequestEntity(
        title: _courseTitleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: "NA",
        tags: "NA",
        thumbnail: File(_thumbnailPath!),
        price: _priceController.text.trim(),
      );

      debugPrint(
          "Form data : \n${course.title}  ,\n${course.description}  ,\n thumbnail: ${course.thumbnail}  , \n ${course.price}  ");
      context.read<CreateCourseBloc>().add(AddCourse(course: course));
    }
  }

  void clearCourseData() async {
    if (courseId != null) {
      print("----Course Deletion Succesful from Local DB----");
      final db = getIt<DBHelper>();
      await db.deleteCourse(id: courseId!);
    }
  }

  Future<bool> _addToDB() async {
    final db = getIt<DBHelper>();
    final res = await db.insertCourse(
      title: _courseTitleController.text.trim(),
      desc: _descriptionController.text.trim(),
      price: _priceController.text.trim(),
      imageFile: File(_thumbnailPath!),
    );
    return res;
  }

  void _clearControllers() {
    _courseTitleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _thumbnailPath = null;
  }

  @override
  void dispose() {
    _courseTitleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCourseBloc, CreateCourseState>(
      listener: (context, state) {
        if (state is CreateCourseError) {
          EasyLoading.dismiss();
          showSnackBar(context, "Course Creation Failed! ${state.error}",
              type: "error");
        }
        if (state is CreateCourseSuccess) {
          EasyLoading.dismiss();
          showSnackBar(
              context, "Course Created Succefully! You can now add sections");
          clearCourseData();
          _clearControllers();
          Navigator.pushReplacementNamed(context, AppRoutes.ADD_SECTION,
              arguments: {"courseId": state.response.courseId});
        }
      },
      builder: (context, state) {
        if (state is CreateCourseLoading) {
          EasyLoading.show(
            indicator: const CircularProgressIndicator(),
            maskType: EasyLoadingMaskType.clear,
            dismissOnTap: true,
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Create Course')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                    height: 250,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 0.7)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Course Name ',
                              style: TextStyle(
                                fontSize: 18,
                                color: HexColor('135063'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 30,
                              width: 150,
                              child: TextFormField(
                                controller: _courseTitleController,
                                cursorHeight: 12,
                                cursorWidth: 1.5,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Add Course Name',
                                    hintStyle: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    errorStyle: const TextStyle(
                                      fontSize: 10,
                                      height:
                                          0.8, // Reduces space for error text
                                      color: Colors
                                          .white, // Error text appears inside the field
                                    ),
                                    isDense: true,
                                    filled: true,
                                    fillColor: HexColor('3572EF')),
                                validator: (value) =>
                                    value!.isEmpty ? 'required' : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _pickThumbnail,
                          child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                color: HexColor('3572EF'),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: _thumbnailPath == null
                                  ? imageBytes == null
                                      ? const Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_a_photo,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'Add Image',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        )
                                      : Image.memory(imageBytes!)
                                  : Image.file(
                                      File(_thumbnailPath!),
                                      fit: BoxFit.fitWidth,
                                    )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  //Description and Price
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 0.7)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description ',
                          style: TextStyle(
                            fontSize: 18,
                            color: HexColor('135063'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: HexColor('3572EF'),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: _descriptionController,
                            cursorHeight: 12,
                            cursorWidth: 1.5,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: 'Add Description...',
                                hintStyle: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                                contentPadding: const EdgeInsets.only(left: 10),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                filled: true,
                                fillColor: HexColor('3572EF')),
                            maxLines: 3,
                            validator: (value) =>
                                value!.isEmpty ? '*description required' : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'Price ',
                              style: TextStyle(
                                  fontSize: 18, color: HexColor('135063')),
                            ),
                            const SizedBox(width: 14),
                            SizedBox(
                              height: 30,
                              width: 100,
                              child: TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Set Price...',
                                    hintStyle: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: HexColor('3572EF')),
                                validator: (value) =>
                                    value!.isEmpty ? '*price required' : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                              text: "Save Draft",
                              backgroungColor: HexColor('050C9C'),
                              textStyle: appStyle(
                                  size: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              borderSide: const BorderSide(),
                              customFun: () async {
                                final currentContext = context;
                                final res = await _addToDB();
                                if (currentContext.mounted) {
                                  if (res) {
                                    showSnackBar(
                                        context, "Course is added to draft!");
                                  }
                                  _clearControllers();
                                  Navigator.pop(context);
                                }
                              })),
                      const SizedBox(width: 5),
                      Expanded(
                        child: CustomButton(
                            text: "Create",
                            backgroungColor: Colors.white,
                            textStyle: appStyle(
                                size: 14,
                                color: HexColor('050C9C'),
                                fontWeight: FontWeight.w700),
                            borderSide:
                                BorderSide(color: HexColor('050C9C'), width: 2),
                            customFun: () {
                              final currentContext = context;
                              _createCourse(currentContext);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

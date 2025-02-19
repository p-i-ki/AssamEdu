import 'dart:io';

import 'package:assam_edu/features/course/course_create/domain/entities/create_course.dart';
import 'package:assam_edu/features/course/course_create/presentation/bloc/create_course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hexcolor/hexcolor.dart';
//im '../../domain/course_entity.dart';

class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage({super.key});

  @override
  State<CreateCoursePage> createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final _courseNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String? _thumbnailPath;
  final List<Chapter> _chapters = [];
  final List<DemoMaterial> _demoMaterials = [];

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

    //final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   setState(() {
    //     _thumbnailPath = pickedFile.path;
    //   });
    // } else {
    //   return;
    // }
  }

  void _addChapter() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (pickedFile != null && pickedFile.files.isNotEmpty) {
      final videoPath = pickedFile.files.first.path;

      setState(() {
        _chapters.add(
          Chapter(
            title: '', // Placeholder for the title field
            type: 'Video', // Specify the type as "Video"
            uploadPath: videoPath!,
            description: '', // Placeholder for description field
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video selected')),
      );
    }
  }
  // void _addChapter() {
  //   setState(() {
  //     _chapters.add(Chapter(
  //       title: '',
  //       type: '',
  //       uploadPath: '',
  //       description: '',
  //     ));
  //   });
  // }

  // void _addDemoMaterial() {
  //   setState(() {
  //     _demoMaterials.add(DemoMaterial(
  //       title: '',
  //       type: '',
  //       uploadPath: '',
  //       description: '',
  //     ));
  //   });
  // }

  void _createCourse(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_thumbnailPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thumbnail is required')),
        );
        return;
      }

      if (_chapters.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('At least one chapter is required')),
        );
        return;
      }

// ++++++ We may use GetIt here in future ++++++++
      final course = CreateCourseRequestEntity(
        courseName: _courseNameController.text,
        description: _descriptionController.text,
        price: _priceController.text,
        thumbnailPath: _thumbnailPath!,
        chapters: _chapters,
        demoMaterials: _demoMaterials,
      );

      context.read<CreateCourseBloc>().add(AddCourse(course: course));

      // context.read<CreateCourseBloc>().add(AddCourse(
      //       courseName: _courseNameController.text.trim(),
      //       description: _descriptionController.text.trim(),
      //       price: _priceController.text.trim(),
      //       thumbnailPath: _thumbnailPath!,
      //       chapters: _chapters,
      //       demoMaterials: _demoMaterials,
      //     ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Course')),
      body: BlocConsumer<CreateCourseBloc, CreateCourseState>(
        listener: (context, state) {
          if (state is CreateCourseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Course uploaded successfully')),
            );
            Navigator.pop(context);
          } else if (state is CreateCourseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Course Name
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
                                controller: _courseNameController,
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
                                ? const Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Add Image',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  )
                                : Image.file(
                                    File(_thumbnailPath!),
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
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
                                    value!.isEmpty ? 'Price is required' : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Add Chapters Section
                  Container(
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 0.7)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chapters ',
                          style: TextStyle(
                            fontSize: 18,
                            color: HexColor('135063'),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: HexColor('3572EF'),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const Text(
                                '1',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 25,
                                width: 60,
                                child: TextFormField(
                                  controller: _priceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: 'Title',
                                      hintStyle: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                      contentPadding: EdgeInsets.only(left: 10),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white),
                                  validator: (value) => value!.isEmpty
                                      ? 'Price is required'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                            child: Column(
                          children: [
                            IconButton(
                              onPressed: _addChapter,
                              icon: Icon(
                                Icons.add_circle_outline_outlined,
                                size: 80,
                                color: Colors.blue[300],
                              ),
                            ),
                            const Text(
                              'Add Chapter',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )),
                        const SizedBox(height: 10),
                        Text(
                          'Demo Material ',
                          style: TextStyle(
                            fontSize: 18,
                            color: HexColor('135063'),
                          ),
                        ),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: HexColor('3572EF'),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const Text(
                                '1',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 25,
                                width: 60,
                                child: TextFormField(
                                  controller: _priceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: 'Title',
                                      hintStyle: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                      contentPadding: EdgeInsets.only(left: 10),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white),
                                  validator: (value) => value!.isEmpty
                                      ? 'Price is required'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text('Chapters:',
                  //     style: Theme.of(context).textTheme.titleSmall),
                  // const SizedBox(height: 8),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: _chapters.length,
                  //   itemBuilder: (context, index) {
                  //     final chapter = _chapters[index];
                  //     return ListTile(
                  //       title: Text(chapter.title.isEmpty
                  //           ? 'Untitled Chapter'
                  //           : chapter.title),
                  //       subtitle: Text(chapter.uploadPath),
                  //     );
                  //   },
                  // ),
                  // const SizedBox(height: 8),
                  // ElevatedButton(
                  //   onPressed: _addChapter,
                  //   child: const Text('Add Chapter'),
                  // ),

                  const SizedBox(height: 16),
                  //Buttons

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide.none),
                            backgroundColor: HexColor('050C9C'),
                            padding: const EdgeInsets.all(8),
                          ),
                          child: const Text(
                            'Save Draft',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _createCourse(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side:
                                BorderSide(color: HexColor('050C9C'), width: 2),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(8),
                          ),
                          child: Text(
                            'Create',
                            style: TextStyle(
                                color: HexColor('050C9C'),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // // Create Course Button
                  // const SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     _createCourse(context);
                  //   },
                  //   child: const Text('Create Course'),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

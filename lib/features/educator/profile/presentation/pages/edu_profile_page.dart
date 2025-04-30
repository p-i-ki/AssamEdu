import 'dart:io';

import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/common/widgets/common_widgets.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/features/educator/profile/domain/entities/educator_profile.dart';
import 'package:assam_edu/features/educator/profile/presentation/bloc/eudcator_profile_bloc.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../core/utlis/show_snack_bar.dart';

class EduProfilePage extends StatefulWidget {
  const EduProfilePage({super.key});

  @override
  State<EduProfilePage> createState() => _EduProfilePageState();
}

class _EduProfilePageState extends State<EduProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _qualification = TextEditingController();
  String? _profilePicturePath;
  final sv = getIt<StorageServices>();
  String? fullImageUrl;

  @override
  void initState() {
    super.initState();
    List<String?> arr = [];
    arr = sv.getEduProfile(AppConstants.EDUCATOR_PROFILE_INFO);
    if (arr.isNotEmpty) {
      final image = arr[0];
      _bio.text = arr[1]!;
      _qualification.text = arr[2]!;
      debugPrint("----Bio---- ${arr[1]}");
      debugPrint("---- Image URL --- ${arr[0]}");
      final imageUrl = image!.startsWith('http')
          ? image.replaceFirst(RegExp(r'^(?:http|https)://[^/]+'), '')
          : '/$image';

      fullImageUrl = "${AppConstants.SERVER_API_URL}$imageUrl";
      debugPrint('--------- FUll Image URL -------: $fullImageUrl');
    }
  }

  @override
  void dispose() {
    _bio.dispose();
    _qualification.dispose();
    super.dispose();
  }

  // void changePersonalDetails() {}

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
          fullImageUrl = null;
          _profilePicturePath =
              filePath; // Store the image path in a state variable
        });
      }
    } else {
      // User canceled the picker
      debugPrint('No image selected');
      return;
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      if (_profilePicturePath == null || _profilePicturePath!.isEmpty) {
        return showSnackBar(context, 'Thumbnail is required');
      }
      context.read<EudcatorProfileBloc>().add(EducatorProfileCreateEvent(
          bio: _bio.text.trim(),
          qualification: _qualification.text.trim(),
          profilePicture: File(_profilePicturePath!)));
    }
  }

  void saveProfileInfo(Profile profile) async {
    debugPrint("------- Response: $profile");
    debugPrint(
        "Pic: ${profile.profilePicture}  ,Bio: ${profile.bio}  , Qaul: ${profile.qualification}  , InId: ${profile.instructorId}");
    await sv.storeEduProfile([
      (profile.profilePicture),
      (profile.bio),
      (profile.qualification),
      (profile.instructorId)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EudcatorProfileBloc, EudcatorProfileState>(
      listener: (context, state) {
        if (state is EudcatorProfileError) {
          EasyLoading.dismiss();
          debugPrint('---- Error During Course Upload : ${state.error}');
          showSnackBar(context, "Can't Create Profile, Request Failed!");
        }
        if (state is EudcatorProfileSuccess) {
          EasyLoading.dismiss();
          showSnackBar(context, "Profile Creation Successful!");
          saveProfileInfo(state.profile);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is EudcatorProfileLoading) {
          EasyLoading.show(
            indicator: const CircularProgressIndicator(),
            maskType: EasyLoadingMaskType.clear,
            dismissOnTap: true,
          );
        }
        return SafeArea(
          child: Scaffold(
            backgroundColor: HexColor('FDF5E7'),
            body: Container(
              margin: const EdgeInsets.only(
                top: 25,
              ),
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: HexColor('050C9C').withValues(alpha: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 25),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: HexColor('FFFFFF'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Personal Details',
                          style: TextStyle(
                            color: HexColor('FFFFFF'),
                            fontSize: 23,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Stack(
                        children: [
                          Positioned(
                            top: constraints.maxHeight *
                                0.07, // Position top at 10% from the top
                            left: constraints.maxWidth *
                                0.04, // Position left at 10% from the left
                            width: constraints.maxWidth *
                                0.92, // Width is 80% of parent width
                            height: constraints.maxHeight *
                                0.87, // Height is 80% of parent height
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 2, color: HexColor('FFFFFF')),
                              ),
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 15,
                                    children: [
                                      GestureDetector(
                                        onTap: _pickThumbnail,
                                        child: Container(
                                          height: 100.h,
                                          width: 100.h,
                                          decoration: BoxDecoration(
                                            color: HexColor('E9EBFD'),
                                            border: Border.all(
                                                width: 5,
                                                color: HexColor('66300E')
                                                    .withValues(alpha: 0.6)),
                                            borderRadius:
                                                BorderRadius.circular(70),
                                          ),
                                          child: fullImageUrl != null &&
                                                  fullImageUrl!.isNotEmpty
                                              ? ClipOval(
                                                  child: Image.network(
                                                    fullImageUrl!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : ClipOval(
                                                  child: _profilePicturePath !=
                                                          null
                                                      ? Image.file(
                                                          File(
                                                              _profilePicturePath!),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          "assets/images/person.jpeg",
                                                          fit: BoxFit.cover,
                                                        )),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Bio: ',
                                            style: TextStyle(
                                              color: HexColor('FFFFFF'),
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: CstmTextFormField(
                                                controller: _bio,
                                                hintText: "Bio",
                                                fillColor: HexColor('FFF0D3')
                                                    .withValues(alpha: 0.3),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please enter bio";
                                                  }
                                                  return null;
                                                }),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Qualification: ',
                                            style: TextStyle(
                                              color: HexColor('FFFFFF'),
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: CstmTextFormField(
                                                controller: _qualification,
                                                hintText:
                                                    "Example-B.Tech in CSE",
                                                fillColor: HexColor('FFF0D3')
                                                    .withValues(alpha: 0.3),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please enter qualification";
                                                  }
                                                  return null;
                                                }),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      if (state is EudcatorProfileLoading)
                                        const CircularProgressIndicator()
                                      else
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: CustomButton(
                                                    text: "Cancel",
                                                    backgroungColor:
                                                        HexColor('FFF0D3'),
                                                    textStyle: appStyle(
                                                        size: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    borderSide: BorderSide.none,
                                                    customFun: () {
                                                      _profilePicturePath =
                                                          null;
                                                      _bio.clear();
                                                      _qualification.clear();
                                                      setState(() {});
                                                    })),
                                            const SizedBox(width: 16),
                                            Expanded(
                                                child: CustomButton(
                                                    text: "Save",
                                                    backgroungColor:
                                                        Colors.white,
                                                    textStyle: appStyle(
                                                        size: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    borderSide: BorderSide.none,
                                                    customFun: _saveProfile)),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
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

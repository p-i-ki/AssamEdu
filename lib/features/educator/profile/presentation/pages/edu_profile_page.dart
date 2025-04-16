import 'package:assam_edu/core/common/widgets/app_style.dart';
import 'package:assam_edu/core/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EduProfilePage extends StatefulWidget {
  static const String routeName = '/personal-details';
  const EduProfilePage({super.key});

  @override
  State<EduProfilePage> createState() => _EduProfilePageState();
}

class _EduProfilePageState extends State<EduProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _mobileNumber;
  late TextEditingController _dateOfBirth;
  late TextEditingController _academicQualification;
  late TextEditingController _address;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with initial values
    _mobileNumber = TextEditingController(text: '+91 6001288782');
    _dateOfBirth = TextEditingController(text: '16-01-2001');
    _academicQualification = TextEditingController(text: 'Under Graduate');
    _address =
        TextEditingController(text: '6th Bylane, Baihata Chariali, Barpeta');
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _mobileNumber.dispose();
    _dateOfBirth.dispose();
    _academicQualification.dispose();
    _address.dispose();
    super.dispose();
  }

  void changePersonalDetails() {}

  // Future<void> _saveProfile() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
                            border:
                                Border.all(width: 2, color: HexColor('FFFFFF')),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Mobile number: ',
                                          style: TextStyle(
                                            color: HexColor('FFFFFF'),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 30,
                                          width: 180,
                                          child: TextFormField(
                                            controller: _mobileNumber,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 6),
                                              filled: true,
                                              fillColor: HexColor('FFF0D3')
                                                  .withValues(alpha: 0.3),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                            ),
                                            style: TextStyle(
                                                height: 1,
                                                fontSize: 14,
                                                color: HexColor('FFFFFF')),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your mobile number';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _mobileNumber.text = value!;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Date of birth: ',
                                          style: TextStyle(
                                            color: HexColor('FFFFFF'),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 30,
                                          width: 130,
                                          child: TextFormField(
                                            controller: _dateOfBirth,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 6),
                                              filled: true,
                                              fillColor: HexColor('FFF0D3')
                                                  .withValues(alpha: 0.3),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                            ),
                                            style: TextStyle(
                                                height: 1,
                                                fontSize: 14,
                                                color: HexColor('FFFFFF')),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              final regex =
                                                  RegExp(r'\S+@\S+\.\S+');
                                              if (!regex.hasMatch(value)) {
                                                return 'Please enter a valid email address';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _dateOfBirth.text = value!;
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Academic qualification: ',
                                          style: TextStyle(
                                            color: HexColor('FFFFFF'),
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                          width: 160,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: _academicQualification,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 6),
                                              filled: true,
                                              fillColor: HexColor('FFF0D3')
                                                  .withValues(alpha: 0.3),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                            ),
                                            style: TextStyle(
                                                height: 1,
                                                fontSize: 14,
                                                color: HexColor('FFFFFF')),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              final regex =
                                                  RegExp(r'\S+@\S+\.\S+');
                                              if (!regex.hasMatch(value)) {
                                                return 'Please enter a valid email address';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _academicQualification.text =
                                                  value!;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Address: ',
                                          style: TextStyle(
                                            color: HexColor('FFFFFF'),
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 230,
                                          child: TextFormField(
                                            controller: _address,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 8,
                                                      top: 2,
                                                      bottom: 1),
                                              filled: true,
                                              fillColor: HexColor('FFF0D3')
                                                  .withValues(alpha: 0.3),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                            ),
                                            style: TextStyle(
                                                height: 1,
                                                fontSize: 14,
                                                color: HexColor('FFFFFF')),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              final regex =
                                                  RegExp(r'\S+@\S+\.\S+');
                                              if (!regex.hasMatch(value)) {
                                                return 'Please enter a valid email address';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _address.text = value!;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  if (_isLoading)
                                    const CircularProgressIndicator()
                                  else
                                    Row(
                                      // mainAxisAlignment:
                                      //    MainAxisAlignment.spaceEvenly,
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
                                                customFun: () {})),
                                        const SizedBox(width: 16),
                                        Expanded(
                                            child: CustomButton(
                                                text: "Save",
                                                backgroungColor: Colors.white,
                                                textStyle: appStyle(
                                                    size: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                borderSide: BorderSide.none,
                                                customFun: () {})),
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
  }
}

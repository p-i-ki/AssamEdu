import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../core/utlis/user_profile_photo.dart';

class ProfileEditpage extends StatefulWidget {
  static const String routeName = '/profile-edit';
  const ProfileEditpage({super.key});

  @override
  State<ProfileEditpage> createState() => _ProfileEditpageState();
}

class _ProfileEditpageState extends State<ProfileEditpage> {
  final _formKey = GlobalKey<FormState>();
  String _name = 'Rupam jyoti Baishy';
  String _email = 'rupomdon2003@gmail.com';
  bool _isLoading = false;

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

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
              color: HexColor('66300E').withValues(alpha: 1),
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
                      'Profile Edit',
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
                      // Other widgets or fields can go here
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
                                  const SizedBox(height: 10),
                                  const UserProfilePhoto(
                                    image: 'assets/images/person.jpeg',
                                  ),
                                  //  const SizedBox(height: 6),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Change Profile Picture',
                                        style: TextStyle(
                                          color: HexColor('FFFFFF')
                                              .withValues(alpha: 0.8),
                                          fontSize: 12,
                                        ),
                                      )),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Name: ',
                                          style: TextStyle(
                                            color: HexColor('FFFFFF'),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 30,
                                          width: 250,
                                          child: TextFormField(
                                            initialValue: _name,
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
                                                fontSize: 16,
                                                color: HexColor('FFFFFF')),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your name';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _name = value!;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Email: ',
                                          style: TextStyle(
                                            color: HexColor('FFFFFF'),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 30,
                                          width: 250,
                                          child: TextFormField(
                                            initialValue: _email,
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
                                                fontSize: 16,
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
                                              _email = value!;
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
                                          child: ElevatedButton(
                                            onPressed: () {
                                              //Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  HexColor('FFF0D3'),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: HexColor('000000'),
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: _saveProfile,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  HexColor('FFFFFF'),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              'Save',
                                              style: TextStyle(
                                                  color: HexColor('000000'),
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
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

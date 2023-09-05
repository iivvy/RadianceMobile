import 'dart:io';

import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:RadianceAI/prediction/bloc/prediction_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:RadianceAI/profile/bloc/profile_bloc.dart';
import 'package:RadianceAI/user/models/user_model.dart';
import 'package:RadianceAI/user/user_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController historyController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isImageSelected = false;
  XFile? imageFile;
  _pickImagefromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = XFile(pickedImage.path); 
          isImageSelected = true;
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _pickImagefromCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          imageFile = XFile(pickedImage.path);
          isImageSelected = true;
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  UserService userService = UserService();
  User? user; // User object to store the fetched user information

  @override
  void initState() {
    super.initState();
    fetchUserInformation();
  }

  Future<void> fetchUserInformation() async {
    try {
      User fetchedUser = await userService.fetchUsers();
      setState(() {
        user = fetchedUser;
      });
    } catch (e) {
      print('Error fetching user information: $e');
    }
  }

  bool isPopupOpen = false;

  // Function to toggle the pop-up.
  void togglePopup() {
    setState(() {
      isPopupOpen = !isPopupOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    Align buildAlignInput(String label) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: Text(
            label,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black),
          ),
        ),
      );
    }

    InputDecoration buildInputDecoration(String hintText) {
      return InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        hintText: hintText,
      );
    }

    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded) {
        user = state.user;
      }
      return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: user != null
                ? Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 22.0, left: 10.0, right: 10.0),
                          child: Card(
                            color: const Color.fromRGBO(215, 237, 255, 1),
                            margin: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2.0,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SizedBox(
                                    height: 90.0,
                                    width: width * 0.9,
                                    child: ListTile(
                                        leading: Container(
                                          height: 70.0,
                                          width: 70,
                                          child: CircleAvatar(
                                            radius: 70,
                                            backgroundImage: NetworkImage(
                                                'http://127.0.0.1:8000${user?.profile_picture}'),
                                          ),
                                        ),
                                        title: Text(
                                          " Hello Dr. ${user?.last_name}!",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, left: 7.0),
                                          child: Text(
                                            "Hope you're doing well",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 107, 107, 107),
                                                  letterSpacing: .2),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.only(
                            bottom: 15.0, top: 10.0, left: 15.0),
                        child: Text(
                          "Please enter the patient information for a successfull prediction ✅",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                                child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildAlignInput('First Name'),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'first name';
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.black,
                                    decoration:
                                        buildInputDecoration('first name'),
                                  ),
                                  const SizedBox(height: 15.0),
                                  buildAlignInput('Last Name'),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'last name';
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.black,
                                    decoration:
                                        buildInputDecoration('last name'),
                                  ),
                                  const SizedBox(height: 15.0),
                                  buildAlignInput('Age'),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'age';
                                      }
                                      return null;
                                    },
                                    decoration: buildInputDecoration('age'),
                                  ),
                                  const SizedBox(height: 15.0),
                                  buildAlignInput('History'),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'history';
                                      }
                                      return null;
                                    },
                                    decoration: buildInputDecoration('History'),
                                  )
                                ],
                              ),
                            )),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: Text("Upload from gallery"),
                                            onPressed: () {
                                              _pickImagefromGallery();
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: Text("Upload From Camera"),
                                            onPressed: () {
                                              _pickImagefromCamera();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Stack(children: [
                                Container(
                                  width:
                                      100, // Adjust the width and height as needed
                                  height: 100,
                                  color: Colors
                                      .grey[300], // Change the color as needed
                                  child: const Center(
                                    child: Text(
                                      'Drop Image',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                if (isImageSelected && imageFile != null)
                                  Positioned.fill(
                                      child: Image.file(
                                   File( imageFile!.path),
                                    fit: BoxFit.cover,
                                  ))
                              ]),
                            ),
                            Material(
                              color: Colors.blue[400],
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: MaterialButton(
                                onPressed: () async{
                                  if (formKey.currentState!.validate()) {
                                 BlocProvider.of<PredictionBloc>(context).add(MakePredictionEvent(
                                    predictionData: Patient(
                                      first_name: 'firstNameController.text',
                                      last_name:' lastNameController.text',
                                      age:22,
                                      history: 'historyController.text',
                           
                                    ), imageFile: imageFile
                                  ));
                                  }

                                 
                                },
                                minWidth: 200.0,
                                height: 42.0,
                                color: Colors.blue,
                                child: const Text(
                                  'Predict',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                          
                        ),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(), // Show loading indicator while fetching
          ),
        ),
      );
    });
  }
}

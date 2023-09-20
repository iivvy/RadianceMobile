import 'dart:io';

import 'package:RadianceAI/login/auth_repo.dart';

import 'package:RadianceAI/login/login.dart';

import 'package:RadianceAI/user/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:RadianceAI/user/user_repo.dart';
import 'package:RadianceAI/prediction/upload_photo_test.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ImageSelector imageSelector = ImageSelector();
    bool isImageSelected = false;
  XFile? imageFile;

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

  Widget _userInfoCard(String label, String value, IconData? icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 30.0, top: 10.0),
          alignment: Alignment.topLeft,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 5),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Color.fromARGB(255, 158, 158, 158)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 20,
                    color: const Color(0xFF758ECD),
                  ),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentProfilePicture =
        'http://127.0.0.1:8000${user?.profile_picture}';
    // Initialize it with your current profile picture URL

    void changeProfilePicture() {
      // Implement your logic here to change the profile picture URL
      setState(() {
        currentProfilePicture = 'new_profile_picture_url.jpg';
      });
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        elevation: 0,
        // title: Text('Account Info',style: TextStyle(color: Colors.black),),
        actions: const [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          SizedBox(width: 20),
        ],
      ),
      backgroundColor: Color(0xfff7f7f7),
      body: Center(
        child: user != null
            ? SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,

                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                           showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
                                                  actions: <Widget>[
                                                    CupertinoDialogAction(
                                                      child: Text(
                                                          "Upload from gallery"),
                                                      onPressed: () {
                                                        imageSelector.pickImageFromGallery();
                                                      },
                                                    ),
                                                    CupertinoDialogAction(
                                                      child: Text(
                                                          "Upload From Camera"),
                                                      onPressed: () {
                                                        imageSelector.pickImageFromCamera();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                      },
                      child: Stack(children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            (currentProfilePicture),
                          ),
                        ),
                        Positioned(
                          bottom: -15,
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: const Color(0xFF758ECD),
                            ),
                            onPressed: () {
                              // Add your edit profile logic here
                            },
                          ),
                        ),
                          if (isImageSelected &&
                                              imageFile != null)
                                            Positioned.fill(
                                                child: Image.file(
                                              File(imageFile!.path),
                                              fit: BoxFit.cover,
                                            ))
                      ]),
                    ),
                    const SizedBox(height: 25),
                    _userInfoCard('Full Name:',
                        user!.first_name + ' ' + user!.last_name, Icons.person),
                    _userInfoCard('Email:', user!.email, Icons.email),
                    _userInfoCard('Age:', '${user!.age}', Icons.cake),
                    _userInfoCard(
                        'hospital:', '${user!.hospital}', Icons.local_hospital),
                    _userInfoCard('speciality:', user!.speciality,
                        Icons.medical_services),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
                      child: Material(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18.0)),
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side:
                                    const BorderSide(color: Color(0xFF758ECD))),
                            minWidth: 200.0,
                            height: 50.0,
                            onPressed: () async {
                              showDeleteAlert(context);
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: Color(0xFF758ECD),
                                      fontSize: 24.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Icon(
                                  Icons.logout,
                                  color: Color(0xFF758ECD),
                                  size: 25.0,
                                  weight: 15.0,
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(), // Show loading indicator while fetching
      ),
    );
  }

  void showDeleteAlert(BuildContext context) async {
    await showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text("confirmLogout"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("Ok"),
            onPressed: () async {
              final authService = AuthenticationService();
              await authService.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));

              // Display a message to confirm successful logout
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out successfully!"),
                ),
              );
            },
          ),
          CupertinoDialogAction(
            child: const Text("cancel"),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

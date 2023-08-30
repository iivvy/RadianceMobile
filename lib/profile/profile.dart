import 'dart:math';

import 'package:RadianceAI/login/auth_repo.dart';
import 'package:RadianceAI/login/bloc/auth_bloc.dart';
import 'package:RadianceAI/login/login.dart';
import 'package:RadianceAI/profile/avatar_widget.dart';
import 'package:RadianceAI/user/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:RadianceAI/user/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import your user repository

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          padding: const EdgeInsets.only(left: 30.0),
          alignment: Alignment.topLeft,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 1),
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
                    color: const Color.fromARGB(255, 140, 111, 235),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: user != null
            ? Column(
                // mainAxisAlignment: MainAxisAlignment.center,

                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'http://127.0.0.1:8000${user?.profile_picture}'),
                  ),
                  const SizedBox(height: 25),
                  _userInfoCard('Full Name:',
                      user!.first_name + ' ' + user!.last_name, Icons.person),
                  _userInfoCard('Email:', user!.email, Icons.email),
                  _userInfoCard('Age:', '${user!.age}', Icons.cake),
                  _userInfoCard(
                      'hospital:', '${user!.hospital}', Icons.local_hospital),
                  _userInfoCard(
                      'speciality:', user!.speciality, Icons.medical_services),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
                    child: Material(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(18.0)),
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Color.fromARGB(255, 152, 36, 194))),
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
                                    color: Color.fromARGB(255, 152, 36, 194),
                                    fontSize: 24.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Icon(
                                Icons.logout,
                                color: Color.fromARGB(255, 152, 36, 194),
                                size: 25.0,
                                weight: 15.0,
                              )
                            ],
                          )),
                    ),
                  ),
            
            
                ],
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));

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

import 'dart:math';

import 'package:RadianceAI/profile/avatar_widget.dart';
import 'package:RadianceAI/user/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:RadianceAI/user/user_repo.dart'; // Import your user repository

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
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 20,
                    color: Color.fromARGB(255, 140, 111, 235),
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
                  const SizedBox(height: 20),
                  _userInfoCard('Full Name:', user!.first_name +' '+user!.last_name, Icons.person),
                  _userInfoCard('Email:', user!.email, Icons.email),
                  _userInfoCard('Age:', '${user!.age}', Icons.cake),
                  _userInfoCard(
                      'hospital:', '${user!.hospital}', Icons.local_hospital),
                  _userInfoCard(
                      'speciality:', user!.speciality, Icons.medical_services),
                ],
              )
            : const CircularProgressIndicator(), // Show loading indicator while fetching
      ),
    );
  }
}

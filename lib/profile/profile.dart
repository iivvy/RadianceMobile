import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Center(child: Column(
      //       children: [
      //         Column(
      //           children: [
      //             Container(
      //               child: ,
      //             )
      //           ],
      //         )
      //       ],
      //     ),),
      //   ),
      // ),
      backgroundColor: Colors.blue,
    );
  }
}

import 'package:RadianceAI/profile/bloc/profile_bloc.dart';
import 'package:RadianceAI/user/models/user_model.dart';
import 'package:RadianceAI/user/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded) {
        user = state.user;
      }
      return Scaffold(
        body: Center(
          child: user != null
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'http://127.0.0.1:8000${user?.profile_picture}'),
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            "Hello, Dr. ${user?.last_name}",
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'poppins',fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : const CircularProgressIndicator(), // Show loading indicator while fetching
        ),
      );
    });
  }
}

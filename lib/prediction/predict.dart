import 'package:flutter/material.dart';
import 'package:RadianceAI/profile/bloc/profile_bloc.dart';
import 'package:RadianceAI/user/models/user_model.dart';
import 'package:RadianceAI/user/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                        padding: const EdgeInsets.only(top: 22.0,left: 10.0,right: 10.0),
                        child: Card(
                          color: Color.fromRGBO(215, 237, 255, 1),
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
                                                color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 2.0,left: 7.0),
                                        child: Text(
                                          "Hope you're doing well",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(255, 107, 107, 107),
                                                letterSpacing: .2),
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        )),

                    // Card(
                    //   color: Colors.red,
                    //    margin:  const EdgeInsets.only(left:10.0,right:10.0,top:5.0,bottom: 5.0),

                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     elevation: 0.0,

                    //   child: Row(

                    //     // mainAxisAlignment: MainAxisAlignment.start,
                    //     // crossAxisAlignment: CrossAxisAlignment.start,

                    //     children: [
                    //       CircleAvatar(
                    //         radius: 30,
                    //         backgroundImage: NetworkImage(
                    //             'http://127.0.0.1:8000${user?.profile_picture}'),
                    //       ),
                    //       const SizedBox(width: 15.0),
                    //       Text(
                    //         "Hello, Dr. ${user?.last_name}",
                    //         style: const TextStyle(
                    //             fontSize: 20.0, fontFamily: 'poppins',fontWeight: FontWeight.w600),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Text(
                          "Drop your CXR image here or Take a photo of one",
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                )
              : const CircularProgressIndicator(), // Show loading indicator while fetching
        ),
      );
    });
  }
}

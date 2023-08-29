// ignore_for_file: sort_child_properties_last

import 'dart:math';

import 'package:RadianceAI/profile/avatar_widget.dart';
import 'package:RadianceAI/profile/bloc/profile_bloc.dart';
import 'package:RadianceAI/user/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required this.userProfile}) : super(key: key);
  final User userProfile;


  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

   late User userProfile;
   final _formKey = GlobalKey<FormState>();
    @override
  void initState() {

    userProfile = widget.userProfile;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:Center(
              child: Column(
                children: [
                  Column(children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: AvatarWidget(
                              key: ValueKey(Random().nextInt(100)),
                              avatar: userProfile.profile_picture,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                            ),
                          ),
                        ]),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.send,
      
                                decoration: const InputDecoration(
                                  hintText: "username",
                                ),
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        PatchProfileEvent(value: {
                                      'name': userProfile.first_name,
                                    }));
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "error.emptyText";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding( padding: const EdgeInsets.all(15.0),
                            child: Text(userProfile.first_name),
                            )
                    ],
                    
                  )
                ],
              ),
              
              
            ),
            ),

            
            ),
      ),
    );
  }
}

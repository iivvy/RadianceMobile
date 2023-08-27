import 'package:RadianceAI/profile/bloc/profile_bloc.dart';
import 'package:RadianceAI/profile/utils.dart';
import 'package:RadianceAI/radiance_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key, required this.avatar}) : super(key: key);
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var response = await showChoiceDialog(context);
        if (response is XFile?) {
          BlocProvider.of<ProfileBloc>(context).add(
            PostUserAvatarEvent(avatar: response),
          );
        }
      },
      child: avatar.isNotEmpty
          ? CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage("${RadianceAI.baseUrl}/$avatar",
                  headers: BlocProvider.of<ProfileBloc>(context)
                      .profileService
                      .getHeadersWithAuthorization),
            )
          : const CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage("assets/images/avatar.jpg"),
            ),
    );
  }
}
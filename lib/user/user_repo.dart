
import 'dart:io';
import 'package:RadianceAI/main_repo.dart';
import 'package:RadianceAI/radiance_config.dart';
import 'package:RadianceAI/user/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


//    Future<User> fetchUsers() async {
//     Uri uri = Uri.parse(RadianceAI.profile);
//     var response = await http.get(uri, headers:    {
//       'Accept': 'application/json',
//       'Authorization': `Bearer ${token}`
//     });

//     if (response.statusCode == HttpStatus.ok) {
//       final String userInfo = response.body.toString();

//       return User.fromJson(userInfo);
//     } else {
//       throw Exception('Failed to load user info ');
//     }
//   }

class UserService extends MainRepository {
  Future<String?> getAccessToken() async {
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'access_token');
  return token;
}

Future<User> fetchUsers() async {
  String? token = await getAccessToken();

  print('access token $token');

  if (token == null) {
    throw Exception('Access token not available');
  }

  Uri uri = Uri.parse('http://127.0.0.1:8000/api/auth/test-token');
  var response = await http.post(uri,  headers: {
    'accept': 'application/json',
    'Authorization': 'Bearer $token', // Use the retrieved token here
  });
  if (response.statusCode == HttpStatus.ok) {
    // print(response.body);
    final String userInfo = response.body.toString();
    print(' user info is $userInfo');
    return User.fromJson(userInfo);
    // return userInfo;
  } else {
    throw Exception('Failed to load user info');
  }
}


 





  Future<bool> postUserAvatar(XFile? avatar, int userId) async {
    var stream = http.ByteStream(Stream.castFrom(avatar!.openRead()));
    var length = await avatar.length();

    var uri = Uri.parse(RadianceAI.getContactsPhoto(userId));
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(getHeadersWithAuthorization);
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(avatar.path));
    request.files.add(multipartFile);
    var response = await request.send();

    if (response.statusCode == HttpStatus.created) {
      imageCache!.clear();
      imageCache!.clearLiveImages();
      return true;
    } else {
      throw Exception();
    }
  }
}
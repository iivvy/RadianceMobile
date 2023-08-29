import 'dart:convert';


import 'package:http/http.dart' as http;

import '../main_repo.dart';
import '../radiance_config.dart';

class AuthenticationService extends MainRepository {
  MainRepository mainRepository = MainRepository();

  ///Autenticate user & get token and save it
  Future<bool> userAuthentication(String userName, String userPassword) async {
    final uri = Uri.parse(RadianceAI.login);
    Map<String, String> params = {
      //user1
      'username': userName,

      //password
      "password": userPassword,
      "scope": "openid",
      "grant_type": "password"
    };
    var response = await http.post(uri, headers: getBaseHeaders, body: params);
    print(response.body);
    if (response.body.contains('error')) {
      return false;
    } else {
      var jsonResponse = jsonDecode(response.body);
      setAuthorization(jsonResponse["access_token"]);
      return true;
    }
  }

  /// function of Get Session
  Future<bool> getSession() async {
    await setUserAgent();

    return true;
  }
}
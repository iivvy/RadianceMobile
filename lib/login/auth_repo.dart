import 'dart:convert';


import 'package:http/http.dart' as http;

import '../main_repo.dart';
import '../radiance_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService extends MainRepository {
  MainRepository mainRepository = MainRepository();



  Future<void> storeLoginInfo(String accessToken) async {
    const storage = FlutterSecureStorage();
    
    await storage.write(key: 'access_token', value: accessToken);
}
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
    // print(response.body);
    if (response.body.contains('error')) {
      return false;
    } else {
      var jsonResponse = jsonDecode(response.body);
      setAuthorization(jsonResponse["access_token"]);
      String accessToken = jsonResponse['access_token'];
      print('auth token');
      print(accessToken);
      await storeLoginInfo(accessToken);
      return true;
    }
  }
  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'access_token');
    // You can also perform additional logout-related tasks here
  }

  /// function of Get Session
  Future<bool> getSession() async {
    await setUserAgent();

    return true;
  }
}
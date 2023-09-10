import 'dart:convert';


import 'package:RadianceAI/main_repo.dart';
import 'package:RadianceAI/radiance_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReportService extends MainRepository {
  Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');
    return token;
  }

  Future<Map<String, dynamic>> getReport(String predictId) async {
    String? token = await getAccessToken();

    Uri uri = Uri.parse(RadianceAI.getPatientReport(predictId));
    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });
    print("this is the response body ---------------------$response");

    if (response.statusCode == 200) {
      final responseBody = response.body;
      print("this is the response body ---------------------$responseBody");

      final Map<String, dynamic> responseJson = jsonDecode(responseBody);
      print("this is the responseJson body ---------------------$responseJson");

      return responseJson;
    } else {
      throw Exception('Failed to load report');
    }
  }
}

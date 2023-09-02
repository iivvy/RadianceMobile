import 'dart:io';

import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:RadianceAI/main_repo.dart';
import 'package:RadianceAI/prediction/models/predict_list_model.dart';
import 'package:RadianceAI/radiance_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';


class PredictService extends MainRepository{
  Future<String?> getAccessToken() async {
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'access_token');
  return token;
}
  Future<PredictionListModel> predictImage(Patient patient) async {
    var accessToken = getAccessToken();

   String data= """{
    "first_name" : "${patient.first_name}",
    "last_name" : "${patient.last_name}",
    "history" : "${patient.history}",
    "age" : "${patient.age}",
   }""";
   var headers =  {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${accessToken}',
    };
    Uri uri = Uri.parse(RadianceAI.predict);
    var response = await http.post(uri, headers: headers, body:data);
    if (response.statusCode == HttpStatus.created) {
      final String rawPredictionsList = response.body.toString();
      return PredictionListModel.fromJson(rawPredictionsList);
    } else {
      throw Exception('Failed to load patients');
    }
  }


Future<Uint8List?> fetchActivationMap(String predictionId) async {
  final url = Uri.parse(RadianceAI.getPatientPrediction(predictionId));

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      // Handle error cases here
      print('Failed to fetch activation map: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // Handle network errors here
    print('Error fetching activation map: $e');
    return null;
  }
}

  
}
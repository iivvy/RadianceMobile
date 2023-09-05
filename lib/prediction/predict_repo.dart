import 'dart:convert';

import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:RadianceAI/main_repo.dart';
import 'package:RadianceAI/prediction/models/predict_list_model.dart';
import 'package:RadianceAI/radiance_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class PredictService extends MainRepository {
  Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');
    return token;
  }

  // Future<PredictionListModel> predictImage(Patient patient, XFile? frt) async {
  //   var accessToken = getAccessToken();
  //   Map<String, dynamic> fullPatient = {
  //     'first_name': patient.first_name,
  //     'last_name': patient.last_name,
  //     'age': patient.age,
  //     'history': patient.history,
  //     'frontal_image': frt?.path, // Assuming XFile has a 'path' property
  //   };
  //   print(fullPatient);
  //   // Map fullPatient = Map.from(patient );
  //   // fullPatient['frontal_image'] = frt.path;
  //   // print(fullPatient);
  //   try {
  //     final response = await http.post(
  //       Uri.parse(RadianceAI.predict),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'multipart/form-data',
  //         'Authorization': 'Bearer ${accessToken}',
  //       },
  //       body: jsonEncode(fullPatient),
  //     );

  //     print("this is the pred reponse ------- ${response.body}");

  //     if (response.statusCode == 200) {
  //       // Parse the response JSON and return the data
  //       return jsonDecode(response.body);
  //     } else {
  //       throw Exception('Failed to make the prediction request');
  //     }
  //   } catch (e) {
  //     throw Exception('An error occurred: $e');
  //   }

  //   //  String data= """{
  //   //   "first_name" : "${patient.first_name}",
  //   //   "last_name" : "${patient.last_name}",
  //   //   "history" : "${patient.history}",
  //   //   "age" : "${patient.age}",
  //   //  }""";
  //   //  var headers =  {
  //   //     'Accept': 'application/json',
  //   //     'Content-Type': 'multipart/form-data',
  //   //     'Authorization': 'Bearer ${accessToken}',
  //   //   };
  //   //   Uri uri = Uri.parse(RadianceAI.predict);
  //   //   var response = await http.post(uri, headers: headers, body:data);
  //   //   if (response.statusCode == HttpStatus.created) {
  //   //     final String rawPredictionsList = response.body.toString();
  //   //     return PredictionListModel.fromJson(rawPredictionsList);
  //   //   } else {
  //   //     throw Exception('Failed to load patients');
  //   //   }
  // }
Future<Map<String, dynamic>> predictImage(Patient patient, XFile frt) async {
  try {
    String? token = await getAccessToken();

   print('access token $token');
    final request = http.MultipartRequest('POST', Uri.parse(RadianceAI.predict));

    request.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });

    request.fields.addAll({
      'first_name': patient.first_name,
      'last_name': patient.last_name,
      'age': patient.age.toString(), // Convert age to a string
      'history':patient.history!,
    });

    if (frt != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'frontal_image',
        frt.path,
        contentType: MediaType('image', 'png'), // Adjust the content type as needed
      ));
    }
    print(request.headers);

    final response = await request.send();
    print("this is thw pred response ${jsonDecode(await response.stream.bytesToString())}");

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return jsonDecode(responseBody);
    } else {
      throw Exception('Failed to make the prediction request');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
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

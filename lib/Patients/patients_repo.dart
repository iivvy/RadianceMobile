import 'package:RadianceAI/Patients/models/patient_list_model.dart';
import 'package:RadianceAI/main_repo.dart';
import 'package:RadianceAI/radiance_config.dart';
import 'package:http/http.dart' as http;

class PatientService extends MainRepository {
  Future<PatientListModel> fetchPatients() async {
    Uri uri = Uri.parse(RadianceAI.getPatients);
    var response = await http.get(uri, headers: getHeadersWithAuthorization);
    if (response.statusCode == 200) {
      final String rawPatientsList = response.body.toString();
      return PatientListModel.fromJson(rawPatientsList);
    } else {
      throw Exception('Failed to load patients');
    }
  }
}

class RadianceAI{
  // static const baseUrl = "http://159.89.7.76/api/";
  static const baseUrl = "http://localhost:8000/api";
  static const  login = '$baseUrl/auth/access-token';
  static const prediction = '$baseUrl/doctor/predict';
  static const updateReport = '$baseUrl/doctor/report';
  static const profile ='$baseUrl/auth/test-token';
  static const profilePhoto = '$baseUrl/doctor/update_profile_picture';
  static const getPatients = '$baseUrl/doctor/patients';
  static const getPatientDetails = '$baseUrl/doctor/patients/names';
  static const predict = '$baseUrl/doctor/predict';
  // static const getpatientprediction = '$baseUrl/doctor/predict/activation/';
  // static const getUser = '$baseUrl/auth/test-token';
  static String getContactsPhoto(int? userId) {
    return "$profile$userId/photo";
  }
  static String getPatientPrediction(String? predId){
    return "$baseUrl/doctor/predict/activation/$predId";

  }
  static String getPatientReport(String? predId){
    return "$baseUrl/doctor/report/$predId";

  }



}
class RadianceAI{
  // static const baseUrl = "http://159.89.7.76/api/";
  static const baseUrl = "http://localhost:8000/api";
  static const  login = '$baseUrl/auth/access-token';
  static const prediction = '$baseUrl/doctor/predict';
  static const report = '$baseUrl/doctor/report';
  static const profile ='$baseUrl/auth/test-token';
  static const profilePhoto = '$baseUrl/doctor/update_profile_picture';
  static const getPatients = '$baseUrl/doctor/patients/names';


}
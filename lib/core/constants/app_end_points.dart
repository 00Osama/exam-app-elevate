class AppEndPoints {
  AppEndPoints._();

  static const String baseUrl = "https://exam.elevateegy.com/api/v1/";

  // Categories
  static const String _auth = "auth";
  static const String _exams = "exams";
  static const String _questions = "questions";
  static const String _subjects = "subjects";

  // Auth
  static const String signIn = "$_auth/signin";
  static const String signUp = "$_auth/signup";
  static const String changePassword = "$_auth/changePassword";
  static const String deleteMe = "$_auth/deleteMe";
  static const String editProfile = "$_auth/editProfile";
  static const String logout = "$_auth/logout";
  static const String profileData = "$_auth/profileData";
  static const String forgotPassword = "$_auth/forgotPassword";
  static const String verifyResetCode = "$_auth/verifyResetCode";
  static const String resetPassword = "$_auth/resetPassword";

  // Subjects / Exams / Questions
  static const String subjects = _subjects;
  static const String exams = _exams;
  static const String questions = _questions;
}
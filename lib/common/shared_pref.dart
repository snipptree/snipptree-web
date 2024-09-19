import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet/common/app_constants.dart';

class SharedPrefs {
  // Private constructor for Singleton
  SharedPrefs._();

  // Static instance of the Singleton
  static final SharedPrefs _instance = SharedPrefs._();

  // Factory constructor returns the static instance
  factory SharedPrefs() {
    return _instance;
  }

  // Instance variable for SharedPreferences
  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setJwtToken(String? token) {
    _prefs.setString(AppConstants.jwtToken, token ?? '');
  }

  String? getJwtToken() {
    return _prefs.getString(AppConstants.jwtToken) ?? '';
  }

  setUserName(String? userName) {
    _prefs.setString(AppConstants.userName, userName ?? '');
  }

  String? getUserName() {
    return _prefs.getString(AppConstants.userName) ?? '';
  }

  setImageUrl(String? imageUrl) {
    _prefs.setString(AppConstants.imageUrl, imageUrl ?? '');
  }

  String? getImageUrl() {
    return _prefs.getString(AppConstants.imageUrl) ?? '';
  }
}

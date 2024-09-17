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

  // Getter to access SharedPreferences
  SharedPreferences get prefs => _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// to store the places updated version once api is successful.
  setAuthExpiry(int? time) {
    prefs.setInt(AppConstants.authExpiry, time ?? DateTime.now().millisecondsSinceEpoch + 6000);
  }

  int? getAuthExpiry() {
    return prefs.getInt(AppConstants.authExpiry) ?? DateTime.now().millisecondsSinceEpoch + 6000;
  }

  setJwtToken(String? token) {
    prefs.setString(AppConstants.jwtToken, token ?? '');
  }

  String? getJwtToken() {
    return prefs.getString(AppConstants.jwtToken) ?? '';
  }

  setUserName(String? userName) {
    prefs.setString(AppConstants.userName, userName ?? '');
  }

  String? getUserName() {
    return prefs.getString(AppConstants.userName) ?? '';
  }

  setImageUrl(String? imageUrl) {
    prefs.setString(AppConstants.imageUrl, imageUrl ?? '');
  }

  String? getImageUrl() {
    return prefs.getString(AppConstants.imageUrl) ?? '';
  }
}

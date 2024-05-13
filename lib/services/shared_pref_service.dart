import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  late SharedPreferences prefs;
  SharedPrefService() {
    createInstance();
  }

  Future<void> createInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  getString(key) {
    return prefs.getString(key);
  }

  bool getBool(key) {
    return prefs.getBool(key) ?? false;
  }

  void setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  void setString(String key, String value) {
    prefs.setString(key, value);
  }

  void setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  int getInt(key) {
    return prefs.getInt(key) ?? -1;
  }
}

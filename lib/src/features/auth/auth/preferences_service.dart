import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance => _sharedPreferences;
}

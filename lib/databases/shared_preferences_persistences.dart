import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferencesPersistences {
  void login() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("loged", true);
    prefs.setInt("userId", 1);
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    bool? logged = prefs.getBool("logged");
    if (logged != null && logged) {
      prefs.setBool("logged", false);
      prefs.remove("userId");
    }
  }
}

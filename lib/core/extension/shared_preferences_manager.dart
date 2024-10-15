import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class SharedPreferencesManager {
  final SharedPreferences _sharedPreferences;
  SharedPreferencesManager(this._sharedPreferences);

  void setUserID(int id) {
    _sharedPreferences.setInt(SharedPreferencesKeys.UserID, id);
  }

  void clearUserID() {
    _sharedPreferences.remove(SharedPreferencesKeys.UserID);
  }

  int? getUserID() {
    int? userID = _sharedPreferences.getInt(SharedPreferencesKeys.UserID);
    return userID;
  }
}

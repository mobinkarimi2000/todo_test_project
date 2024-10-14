import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class SharedPreferencesManager {
  final SharedPreferences _sharedPreferences;
  SharedPreferencesManager(this._sharedPreferences);

  void setPersonID(int id) {
    _sharedPreferences.setInt(SharedPreferencesKeys.UserID, id);
  }

  void clearPersonID() {
    _sharedPreferences.remove(SharedPreferencesKeys.UserID);
  }

  int? getPersonID() {
    int? personID = _sharedPreferences.getInt(SharedPreferencesKeys.UserID);
    return personID;
  }
}

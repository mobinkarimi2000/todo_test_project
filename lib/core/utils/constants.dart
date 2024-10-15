// ignore_for_file: constant_identifier_names

class URLPath {
  static const BASE_URL = 'https://dummyjson.com/';
  static const TODO = 'todos/';
  static const ADD_TODO = 'todos/add';
  static const TODO_LIST = 'todos/users';
}

class Constants {}

class RestApiError {
  static const int FROM_SERVER_ERROR = 500;
  static const int TO_SERVER_ERROR = 599;
  static const int UNAUTHORIZED_ERROR = 599;
}

class SharedPreferencesKeys {
  static const UserID = "userID";
}

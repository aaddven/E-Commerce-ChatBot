import 'package:flutter/foundation.dart';

// Provider for Authentication state management

class AuthProvider with ChangeNotifier {

  // Notifies is the user is valid or not
  Future<bool> login(String username, String password) async {

    if (isValidCredentials(username, password)) {
      notifyListeners();
      return true;
    }

    return false;
  }

  // Matches input credentials
  bool isValidCredentials(String username, String password) {
    return username == 'blitz_demo' && password == 'Blitz@1234';
  }

}

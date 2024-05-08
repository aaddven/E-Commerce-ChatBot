import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_chatbot/providers/login_page/auth_provider.dart';



void main() {
  group('login method', () {
    test('Login with valid credentials should return true', () async {

      final AuthProvider authProvider = AuthProvider();
      final validUsername = 'blitz_demo';
      final validPassword = 'Blitz@1234';


      final result = await authProvider.login(validUsername, validPassword);


      expect(result, true);
    });

    test('Login with invalid credentials should return false', () async {

      final AuthProvider authProvider = AuthProvider();
      final invalidUsername = 'invalid_user';
      final invalidPassword = 'invalid_pass';


      final result = await authProvider.login(invalidUsername, invalidPassword);


      expect(result, false);
    });

    group('isValidCredentials method', () {
      test('Returns true for valid credentials', () {

        final AuthProvider authProvider = AuthProvider();
        final validUsername = 'blitz_demo';
        final validPassword = 'Blitz@1234';


        final isValid = authProvider.isValidCredentials(validUsername, validPassword);


        expect(isValid, true);
      });

      test('Returns false for invalid credentials', () {

        final AuthProvider authProvider = AuthProvider();
        final invalidUsername = 'invalid_user';
        final invalidPassword = 'invalid_pass';


        final isValid = authProvider.isValidCredentials(invalidUsername, invalidPassword);


        expect(isValid, false);
      });
    });
  });
}

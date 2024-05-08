import 'package:ecommerce_chatbot/widgets/login_page/custom_text_field.dart';
import 'package:ecommerce_chatbot/widgets/login_page/login_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_page/auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Asks auth provider to try authenticating and return the state
  void _login(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    try {
      bool success = await authProvider.login(username, password);

      if (success) {
        Navigator.pushReplacementNamed(context, '/chatbot');
      } else {
        _showInvalidCredentialsDialog(context, 'Authentication Failed','Invalid username or password.');
      }
    } catch (e) {
      _showInvalidCredentialsDialog(context, 'Error','An error occurred while logging in.');
    }
  }

  // Alert dialog if login credentials don't match
  void _showInvalidCredentialsDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width*0.3,
        height: MediaQuery.of(context).size.height*.15,
        color:  const Color(0xFF7165E3).withOpacity(0.5) ,
        child: AlertDialog(
          title: Text(title,
                 style:TextStyle(
                   color: Colors.black.withOpacity(1),
                   fontSize: 38.0,
                   fontWeight: FontWeight.w800,
                 ),
          ),
          content: Text(message
            , style:TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'
                , style:TextStyle(
                  color: Colors.black.withOpacity(1),
                  fontSize: 32.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    const isWeb = identical(0, 0.0);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF7165E3).withOpacity(0.1),
              Color(0xFF7165E3).withOpacity(0.3),
              Color(0xFF7165E3).withOpacity(0.5),// Lighter shade

            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome to ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: isWeb? 32.0 : 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'E-commerce Chatbot',
                        style: TextStyle(
                          color: Color(0xFF7165E3),
                          fontSize: isWeb? 36.0 : 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),
                Text(
                  'Please login to continue',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: isWeb? 26.0 : 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                  onSubmitted: (value) => _login(context),
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: _passwordController,
                  obscureText: true,
                  hintText: 'Password',
                  onSubmitted: (value) => _login(context),
                ),
                const SizedBox(height: 25.0),
                LoginButton(label: "LOGIN", onPressed: ()=> _login(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}
